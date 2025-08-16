resource "aws_cognito_user_pool" "this" {
  name = "gym-partner-staging-users"

  username_attributes = ["email"]

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers = true
    require_symbols = true
  }

  mfa_configuration = "OFF"

  schema {
    attribute_data_type = "String"
    name                = "email"
    required = true
    mutable = false
  }
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "gym-partner-staging-users-client"
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["implicit", "code"]
  allowed_oauth_scopes = ["email", "openid", "profile"]

  access_token_validity = 60 # 1 hours
  id_token_validity = 60 # 1 hours
  refresh_token_validity = 30 # 30 days

  token_validity_units {
    access_token = "hours"
    id_token = "hours"
    refresh_token = "days"
  }
}