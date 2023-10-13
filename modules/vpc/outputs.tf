output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "pb_subnet_ids" {
  description = "ID list of public subnet"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id ]
}

output "pv_subnet_ids" {
  description = "ID list of private subnet"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id ]
}
