variable "slack_url" {
  description = "slack hook url, eg. https://hooks.slack.com/services/xxxxxxxxxxxxx"
  type        = string
}
variable "slack_channel" {
  description = "slack channel, eg. #mychannel"
  type        = string
}
variable "slack_user" {
  description = "slack user"
  type        = string
}
variable "iam_account_id" {
  type        = string
  description = "account id the code is allowed to be executed with"
}
