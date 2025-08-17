resource "aws_kms_key" "this" {
  description = "KMS key for encrypting/decrypting Gym Partner API's sensible data"
  deletion_window_in_days = 30
  enable_key_rotation = true
}

resource "aws_kms_alias" "this" {
  name = "alias/gym-partner-encrypt-key"
  target_key_id = aws_kms_key.this.id
}