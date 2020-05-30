resource "aws_codepipeline" "bastion-pipeline" {
  name     = "bastion-ami-pipeline"
  role_arn  = aws_iam_role.bastion-codebuild-role.arn

  artifact_store {
    location = "vpc-cuarentena"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["bastion"]


       configuration = {
        Owner  = "videocursoscloud"
        Repo   = "vpc-cuarentena-packer"
        Branch = "master"
        PollForSourceChanges  = "true"
	OAuthToken = data.aws_secretsmanager_secret_version.github_oauth_token.secret_string

      }
    }
  }

  stage {
    name = "validate"
    action {
      name             = "validate"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts = ["bastion"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.bastion-codebuild-validate.name
      }
    }

  }



stage {
    name = "build"
    action {
      name             = "build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts = ["bastion"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.bastion-codebuild-build.name
      }
    }

  }



 


}
