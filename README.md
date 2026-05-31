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

## Requirements

- ECS Fargate - three separate services, one cluster
- Application Load Balancer with WAF routing to the correct service
- Database: DynamoDB or RDS PostgreSQL - you choose, you justify
- ElastiCache Redis (caching layer for the API)
- SQS queue (click events from API to worker)
- VPC with private subnets. No NAT gateways.
- GitHub Actions with OIDC. No long-lived AWS credentials.
- Zero-downtime deployments with rollback on failure
- Least-privilege IAM throughout
- Terraform with remote state
- Multi-stage Docker builds

Project is currently ongoing
