output "password" {
  value = aws_iam_user_login_profile.DB_user
  # password | Base64 --decode | keybase pgp decrypt
}