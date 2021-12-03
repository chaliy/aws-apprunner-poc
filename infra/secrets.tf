resource random_string recovery-key {
  length = 18
  special = false
}

resource aws_ssm_parameter recovery-key {
  name        = "recovery-key"
  type        = "SecureString"
  value       = random_string.recovery-key.result
}