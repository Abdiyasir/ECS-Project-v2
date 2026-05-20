from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import RedirectResponse
import os, hashlib, time, json, logging
import redis

from .db import put_mapping, get_mapping, get_backend_type, increment_clicks
from .events import publish_click_event

logger = logging.getLogger(__name__)

app = FastAPI()

CACHE_TTL = int(os.environ.get("CACHE_TTL_SECONDS", 300))

_redis: redis.Redis | None = None

try:
    _redis_url = os.environ.get("REDIS_URL")

    if _redis_url:
        _redis = redis.from_url(
            _redis_url,
            socket_connect_timeout=1,
            socket_timeout=0.5,
            decode_responses=True,
        )

        # Validate connection once at startup
        _redis.ping()

        logger.info("Redis connected")
    else:
        logger.warning("REDIS_URL not set — caching disabled")

except redis.RedisError as exc:
    logger.warning("Redis unavailable (%s) — caching disabled", exc)
    _redis = None


def _cache_get(short_id: str) -> dict | None:
    if _redis is None:
        return None

    try:
        raw = _redis.get(f"url:{short_id}")
        return json.loads(raw) if raw else None

    except (redis.RedisError, json.JSONDecodeError):
        return None


def _cache_set(short_id: str, value: dict, ttl: int = CACHE_TTL) -> None:
    if _redis is None:
        return

    try:
        _redis.setex(
            f"url:{short_id}",
            ttl,
            json.dumps(value)
        )

    except redis.RedisError:
        pass


@app.get("/healthz")
def health():
    return {
        "status": "ok",
        "ts": int(time.time()),
        "db": get_backend_type(),
        "redis": "enabled" if _redis is not None else "disabled",
    }


@app.post("/shorten")
async def shorten(req: Request):
    body = await req.json()
    url = body.get("url")

    if not url:
        raise HTTPException(400, "url required")

    short = hashlib.sha256(url.encode()).hexdigest()[:8]

    put_mapping(short, url)

    # Warm cache so first redirect can be served from Redis
    _cache_set(short, {"url": url})

    base_url = os.environ.get("BASE_URL", "")

    return {
        "short": short,
        "url": url,
        "short_url": f"{base_url}/{short}" if base_url else short,
    }


@app.get("/stats/{short_id}")
def stats(short_id: str):
    # Always read from DB so click counts remain accurate
    item = get_mapping(short_id)

    if not item:
        raise HTTPException(404, "not found")

    return {
        "short": short_id,
        "url": item["url"],
        "clicks": item.get("clicks", 0),
    }


@app.get("/{short_id}")
def resolve(short_id: str, request: Request):
    # 1. Try Redis cache first
    item = _cache_get(short_id)

    # 2. Cache miss — query DB and backfill cache
    if item is None:
        item = get_mapping(short_id)

        if not item:
            raise HTTPException(404, "not found")

        _cache_set(short_id, {"url": item["url"]})

    # 3. Increment click count in DB
    increment_clicks(short_id)

    # 4. Publish analytics event to SQS
    publish_click_event(
        short_code=short_id,
        ip=request.client.host if request.client else "unknown",
        user_agent=request.headers.get("user-agent", ""),
        referer=request.headers.get("referer", ""),
    )

    return RedirectResponse(item["url"])