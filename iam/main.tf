resource "aws_iam_user" "this" {
  name = "gym-partner-user"
}

resource "aws_iam_policy" "this" {
  name = "gym-partner-kms"
  description = "Allow API to use KMS key for encryption/decryption"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "kms:Encrypt",
          "kms:Decrypt"
        ],
        Resource = var.kms_arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  user       = aws_iam_user.this.name
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}