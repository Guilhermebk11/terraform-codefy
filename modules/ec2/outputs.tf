# Definição dos outputs do módulo EC2

output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.ec2_instance.id
}

output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.ec2_instance.public_ip
}

output "security_group_id" {
  description = "ID do Security Group da EC2"
  value       = aws_security_group.ec2_sg.id
}
