data "archive_file" "lambdazip" {
  type        = "zip"
  output_path = "${path.module}/artifacts/sns_slack.zip"

  source_dir = "${path.module}/artifacts/lambda/"
}


module "cw_sns_slack" {
  source = "./modules/lambda"

  name          = "sns-slack"
  description   = "notify slack channel on sns topic"
  artifact_file = "${path.module}/artifacts/sns_slack.zip"
  handler       = "sns_slack.lambda_handler"
  runtime       = "python3.8"
  memory_size   = 128
  timeout       = 30
  environment = {
    "SLACK_URL"     = var.slack_url
    "SLACK_CHANNEL" = var.slack_channel
    "SLACK_USER"    = var.slack_user
  }
  tags = local.tags
}


resource "aws_sns_topic_subscription" "slack-endpoint" {
  endpoint               = module.cw_sns_slack.arn
  protocol               = "lambda"
  endpoint_auto_confirms = true
  topic_arn              = aws_sns_topic.cw_topic.arn
}

# allow lambda to be executed from SNS topic
resource "aws_lambda_permission" "sns_lambda_slack_invoke" {
  statement_id  = "sns_slackAllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.cw_sns_slack.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.cw_topic.arn
}
