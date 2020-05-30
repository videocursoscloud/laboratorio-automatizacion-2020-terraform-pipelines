terraform {
  backend "s3" {
    bucket = "vpc-cuarentena"
    key    = "pipelines/terraform/vpc.tfstate"
    region = "eu-west-1"
  }
}

