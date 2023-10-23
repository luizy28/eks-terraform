data "aws_iam_policy_document" "developers" {
  statement {
    sid    = "AllowDevelopers"
    effect = "Allow"
    actions = [
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:DescribeCluster",
      "eks:ListCluster",
      "eks:GetParameter",
      "eks:AccessKubernetesApi",
      "eks:ListUpdates",
      "eks:ListFargateProfiles"
    ]
    resources = ["*"]

  }
}

data "aws_iam_policy_document" "admin" {
  statement {
    sid       = "Allowadmin"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "manager_assume_role" {
  statement {
    sid    = "AllowManagerAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/manager"]
    }
  }
}

data "aws_caller_identity" "current" {}