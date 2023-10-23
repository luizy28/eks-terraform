output "admin_group_name" {
  value = aws_iam_group.admins.name
}

output "developer_group_name" {
  value = aws_iam_group.developers.name
}


