resource aws_iam_role instance-role {
  name = "aws-apprunner-poc-instance-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-policy.json
}

data aws_iam_policy_document instance-access-ssm-role-policy {
  statement {
    actions = ["ssm:GetParameter"]
    effect = "Allow"
    resources = ["arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter*"]
  }
}

resource aws_iam_policy instance-access-ssm-role-policy {
  name = "aws-apprunner-poc-instance-access-ssm-role-policy"
  policy = data.aws_iam_policy_document.instance-access-ssm-role-policy.json
}

resource aws_iam_role_policy_attachment instance-role-attachment {
  role = aws_iam_role.instance-role.name
  policy_arn = aws_iam_policy.instance-access-ssm-role-policy.arn
}

data aws_iam_policy_document instance-assume-policy {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["tasks.apprunner.amazonaws.com"]
    }
  }
}
