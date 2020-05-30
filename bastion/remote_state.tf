terraform {
  backend "s3" {
    bucket = "vpc-cuarentena"
    key    = "pipelines/terraform/bastion.tfstate"
    region = "eu-west-1"
  }
}

