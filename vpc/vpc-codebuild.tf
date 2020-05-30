resource "aws_codebuild_project" "vpc-codebuild-plan" {
  name           = "vpc-codebuild-plan"
  description    = "vpc-codebuild-plan"
  build_timeout  = "5"
  queued_timeout = "5"
  service_role   = aws_iam_role.vpc-codebuild-role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/videocursoscloud/vpc-cuarentena"
    git_clone_depth = 1
    buildspec       = file("vpc-buildspec-plan.yaml")

  }

}










resource "aws_codebuild_project" "vpc-codebuild-apply" {
  name           = "vpc-codebuild-apply"
  description    = "vpc-codebuild-apply"
  build_timeout  = "5"
  queued_timeout = "5"
  service_role   = aws_iam_role.vpc-codebuild-role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/videocursoscloud/vpc-cuarentena"
    git_clone_depth = 1
    buildspec       = file("vpc-buildspec-apply.yaml")

  }

}
