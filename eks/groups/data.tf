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

data "aws_iam_policy_document" "admin_assume_role" {
  statement {
    sid    = "AllowAccountsAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
  }
}

data "aws_iam_policy_document" "admin_role" {
  statement {
    sid       = "AllowAdminAssumeRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Masters-eks-Roles"]
  }
}

data "aws_iam_policy_document" "developers_role" {
  statement {
    sid       = "AllowDevelopersAssumeRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Developers-eks-Role"]
  }
}

data "aws_caller_identity" "current" {}