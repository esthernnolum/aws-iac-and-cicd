variable "codepipeline_role_arn" {
  description = "The ARN of the IAM role for CodePipeline"
  type        = string
}

variable "codebuild_role_arn" {
  description = "The ARN of the IAM role for CodeBuild"
  type        = string
}

variable "amplify_app_id" {
  description = "The ID of the Amplify app"
  type        = string
}

variable "amplify_branch_name" {
  description = "The branch name for Amplify"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

resource "aws_codepipeline" "frontend_pipeline" {
  name     = "frontend-pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn = amorserv-repo.github_connection.arn
        FullRepositoryId = "amorserv-repo/frontend"
        BranchName = "main"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "Amplify"
      version          = "1"
      input_artifacts  = ["source_output"]

      configuration = {
        AppId     = var.amplify_app_id
        BranchName = var.amplify_branch_name
      }
    }
  }
}

resource "aws_codepipeline" "backend_pipeline" {
  name     = "backend-pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn = amorserv-repo.github_connection.arn
        FullRepositoryId = "amorserv-repo/backend"
        BranchName = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.backend_build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "Lambda"
      version          = "1"
      input_artifacts  = ["build_output"]

      configuration = {
        FunctionName = var.lambda_function_name
      }
    }
  }
}

resource "aws_codebuild_project" "backend_build" {
  name          = "backend-build"
  service_role  = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
  }

  source {
    type = "CODEPIPELINE"
  }
}
