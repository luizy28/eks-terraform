output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public" {
  value = module.vpc.public_subnets.*
}

output "private" {
  value = module.vpc.private_subnets.*
}

output "demo_role" {
  value = aws_iam_role.demo.arn
}

output "node_role" {
  value = aws_iam_role.nodes.arn
}

