
data "aws_secretsmanager_secret_version" "github_oauth_token" {
  secret_id = "arn:aws:secretsmanager:eu-west-1:972777588758:secret:githubToken-u3XkvT"
}

