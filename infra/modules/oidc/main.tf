resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

resource "aws_iam_role" "cicd_role" {
  name = "cicd-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Abdiyasir/ECS-Project-v2:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "cicd_attachment" {
  role       = aws_iam_role.cicd_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_policy" "cicd_s3_policy" {
  name        = "cicd-s3-state-policy"
  description = "Grants permissions for S3 remote state and native state locking"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowBucketListing"
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::url-s3-156165"
      },
      {
        Sid    = "AllowStateAndNativeLockFileAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::url-s3-156165/prod/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cicd_s3_policy_attachment" {
  role       = aws_iam_role.cicd_role.name
  policy_arn = aws_iam_policy.cicd_s3_policy.arn
}