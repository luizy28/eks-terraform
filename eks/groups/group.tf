resource "aws_iam_user_login_profile" "DB_masters" {
  count                   = length(var.admins)
  user                    = aws_iam_user.eks_admins[count.index].name
  password_reset_required = true
  # pgp_key                 = "keybase:luiz"
}

resource "aws_iam_user_login_profile" "DB_developers" {
  count                   = length(var.developers)
  user                    = aws_iam_user.eks_developers[count.index].name
  password_reset_required = true
  # pgp_key                 = "keybase:luiz"
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_iam_user" "eks_admins" {
  count         = length(var.admins)
  name          = element(var.admins, count.index)
  force_destroy = true

  tags = {
    Department = "eks-admins"
  }
}

resource "aws_iam_user" "eks_developers" {
  count         = length(var.developers)
  name          = element(var.developers, count.index)
  force_destroy = true

  tags = {
    Department = "eks-developers"
  }
}
resource "aws_iam_group" "admins" {
  name = "admins"
}

resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_membership" "admin_membership" {
  #count = length(var.eks_admins)
  name  = "admin_membership"
  group = aws_iam_group.admins.name
  users = tolist(aws_iam_user.eks_admins[*].name)
}

resource "aws_iam_group_membership" "developer_membership" {
  #count = length(var.eks_developers)
  name  = "developer_membership"
  group = aws_iam_group.developers.name
  users = tolist(aws_iam_user.eks_developers[*].name)
}


resource "aws_iam_group_policy" "admin_policy" {
  name   = "master"
  group  = aws_iam_group.admins.name
  policy = data.aws_iam_policy_document.admin_role.json
}

/*resource "aws_iam_group_membership" "masters_team" {
  name  = "masters_group_membership"
  users = [aws_iam_user.eks_masters.*.name]
  group = aws_iam_group.masters.name
}*/


resource "aws_iam_role" "masters" {
  name               = "Masters-eks-Roles"
  assume_role_policy = data.aws_iam_policy_document.admin_assume_role.json
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.masters.name
  policy_arn = aws_iam_policy.eks_admins.arn
}

resource "aws_iam_policy" "eks_admins" {
  name   = "eks-masterss"
  policy = data.aws_iam_policy_document.admin.json
}

/*resource "aws_iam_group" "developers" {
  count = length(var.groups)
  name  = element(var.groups[0], count.index)
}

resource "aws_iam_group_membership" "developers_team" {
  name  = "developers_group_membership"
  users = [aws_iam_user.eks_developers.*.name]
  group = aws_iam_group.developers.name
}*/

resource "aws_iam_group_policy" "developers_policy" {
  name   = "developers"
  group  = aws_iam_group.developers.name
  policy = data.aws_iam_policy_document.developers_role.json
}

resource "aws_iam_role" "developers" {
  name               = "Developers-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.admin_assume_role.json
}

resource "aws_iam_role_policy_attachment" "developers_policy" {
  role       = aws_iam_role.developers.name
  policy_arn = aws_iam_policy.eks_developers.arn
}

resource "aws_iam_policy" "eks_developers" {
  name   = "eks-developers"
  policy = data.aws_iam_policy_document.developers.json
}