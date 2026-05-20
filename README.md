# URL Shortener - CoderCo ECS Project v2

A URL shortener with click analytics on AWS. Three services, one cluster. The application code is provided. You build everything else.

---

## Services

| Service   | Language | Port | Description |
|------------|------------|------|-------------|
| api        | Python     | 8080 | Shortens URLs, handles redirects, tracks clicks, publishes events to SQS |
| worker     | Go         | -    | Polls SQS for click events, writes analytics to PostgreSQL |
| dashboard  | Go         | 8081 | Analytics API - top URLs, click stats, hourly breakdowns, recent events |

---

