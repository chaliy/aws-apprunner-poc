resource aws_apprunner_service aws-runner-poc {
  service_name = "aws-apprunner-poc"

  source_configuration {
    authentication_configuration {
      connection_arn = var.connection_arn
    }

    code_repository {
      code_configuration {
        configuration_source = "REPOSITORY"

        code_configuration_values {
          # Bug in aws_apprunner_service resource marks resource modified without this section
          # consider removeing this section all togather when bug is fixed
          # ignore values, thouse are defaults
          build_command = ""
          port = "8080"
          runtime = "PYTHON_3"
          runtime_environment_variables = { }
          start_command = ""
        }
      }
      repository_url = "https://github.com/chaliy/aws-apprunner-poc"
      source_code_version {
        type  = "BRANCH"
        value = "main"
      }
    }
  }

  health_check_configuration {
    path = "/api/openapi.json"
    protocol = "HTTP"
  }

  instance_configuration {
    cpu = "1024" // 1 vCPU
    memory = "2048" // 2 GB
    instance_role_arn = aws_iam_role.instance-role.arn
  }

  depends_on = [aws_iam_role.instance-role]
}

resource aws_apprunner_custom_domain_association aap-chaliy-name {
  domain_name = "aap.chaliy.name"
  service_arn = aws_apprunner_service.aws-runner-poc.arn
}

output apprunner_service_url {
  value = "https://${aws_apprunner_service.aws-runner-poc.service_url}"
}