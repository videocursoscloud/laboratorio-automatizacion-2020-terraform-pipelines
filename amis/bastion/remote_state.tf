terraform {
  backend "s3" {
    bucket = "vpc-cuarentena"
    key    = "pipelines/terraform/ami-bastion.tfstate"
    region = "eu-west-1"
  }
}

