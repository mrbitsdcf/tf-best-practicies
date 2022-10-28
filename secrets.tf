resource "random_password" "password" {
  length           = 16
  special          = false
  override_special = "_%@"
}

resource "aws_ssm_parameter" "securestring_parameters" {
  name   = format("rdspassword-%s", terraform.workspace)
  type   = "SecureString"
  value  = random_password.password.result
  key_id = "f339c8d3-0a9f-4b3f-9a99-5d94b1da013f"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "aws_secretsmanager_secret" "secret_database" {
  name                    = "tf-best-practices-secrets"
  kms_key_id              = "f339c8d3-0a9f-4b3f-9a99-5d94b1da013f"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "secret_value" {
  secret_id     = aws_secretsmanager_secret.secret_database.id
  secret_string = random_password.password.result
}
