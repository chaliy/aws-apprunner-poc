resource aws_apprunner_service aws-runner-poc {
  service_name = "aws-apprunner-poc"

  source_configuration {
    authentication_configuration {
      connection_arn = var.connection_arn
    }

    code_repository {
      code_configuration {
        configuration_source = "REPOSITORY"
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
    cpu = "2048" // 2 vCPU
    memory = "4096" // 4 GB
  }
}
