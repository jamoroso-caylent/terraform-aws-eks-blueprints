data "aws_iam_policy_document" "atlantis" {
  statement {
    sid       = "Atlantis"
    effect    = "Allow"
    resources = ["*"]

    actions = ["*"]
  }
}