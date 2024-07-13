resource "aws_amplify_app" "app" {
  name                = "amplify-app"
  repository          = "https://github.com/my-repo/frontend"
  oauth_token         = var.github_token

  environment_variables = {
    NODE_ENV = "production"
  }

  build_spec = filebase64("${path.module}/buildspec.yml")
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.app.id
  branch_name = "main"
}

output "app_id" {
  value = aws_amplify_app.app.id
}

output "branch_name" {
  value = aws_amplify_branch.main.branch_name
}
