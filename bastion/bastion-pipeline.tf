resource "aws_codepipeline" "bastion-pipeline" {
  name     = "bastion-pipeline"
  role_arn  = aws_iam_role.bastion-codebuild-role.arn

  artifact_store {
    location = "bastion-cuarentena"
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
        Repo   = "laboratorio-automatizacion-2020-terraform-bastion"
        Branch = "master"
        PollForSourceChanges  = "true"
	OAuthToken = data.aws_secretsmanager_secret_version.github_oauth_token.secret_string

      }
    }
  }

  stage {
    name = "Plan"
    action {
      name             = "Plan"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts = ["bastion"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.bastion-codebuild-plan.name
      }
    }

  }


 stage {
    name = "Approve"

    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

    }
  }

stage {
    name = "Apply"
    action {
      name             = "Apply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts = ["bastion"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.bastion-codebuild-apply.name
      }
    }

  }

}
