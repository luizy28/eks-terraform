resource "aws_iam_user_login_profile" "DB_masters" {
  count                   = length(var.username)
  user                    = aws_iam_user.eks_masters[count.index].name
  password_reset_required = true
  # pgp_key                 = "keybase:luiz"
}

resource "aws_iam_user" "eks_masters" {
  count         = length(var.username)
  name          = element(var.username, count.index)
  force_destroy = true

  tags = {
    Department = "eks-masters"
  }
}
resource "aws_iam_group" "masters" {
  count = length(var.groups)
  name  = element(var.groups, count.index)
}

resource "aws_iam_group_policy" "masters_policy" {
  name   = "master"
  group  = aws_iam_group.masters[0].name
  policy = data.aws_iam_policy_document.masters_role.json
}

resource "aws_iam_group_membership" "masters_team" {
  name  = "masters_group_membership"
  users = [aws_iam_user.eks_masters[0].name, aws_iam_user.eks_masters[1].name]
  group = aws_iam_group.masters[0].name
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_iam_role" "masters" {
  name               = "Masters-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.masters_assume_role.json
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.masters.name
  policy_arn = aws_iam_policy.eks_masters.arn
}

resource "aws_iam_policy" "eks_masters" {
  name   = "eks-masters"
  policy = data.aws_iam_policy_document.masters.json
}