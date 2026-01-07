# below just tells terraform which cloud provider to use and how terraform should talk to aws


# here its telling terraform when u run and want to talk to aws, download this aws provider plugin
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

#here i am telling terraform to use aws as a cloud provider and i state the region i want to use
provider "aws" {
  region = "eu-west-2"
}

#its the aws credentials on your machine that connects terraform to aws- aws configure