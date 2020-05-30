resource "aws_codebuild_project" "bastion-codebuild-validate" {
  name           = "bastion-codebuild-validate"
  description    = "bastion-codebuild-validate"
  build_timeout  = "5"
  queued_timeout = "5"
  service_role   = aws_iam_role.bastion-codebuild-role.arn

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
    location        = "https://github.com/videocursoscloud/vpc-cuarentena-packer"
    git_clone_depth = 1
    buildspec       = file("bastion-buildspec-validate.yaml")

  }

}











resource "aws_codebuild_project" "bastion-codebuild-build" {
  name           = "bastion-codebuild-build"
  description    = "bastion-codebuild-build"
  build_timeout  = "5"
  queued_timeout = "5"
  service_role   = aws_iam_role.bastion-codebuild-role.arn

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
    location        = "https://github.com/videocursoscloud/vpc-cuarentena-packer"
    git_clone_depth = 1
    buildspec       = file("bastion-buildspec-build.yaml")

  }

}
