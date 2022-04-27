terraform {
  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      configuration_aliases = [ aws.ireland ]

    }
  }
  required_version = ">= 0.13"
}
