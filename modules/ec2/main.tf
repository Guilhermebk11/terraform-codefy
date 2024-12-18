# Configuração da instância EC2, Security Group e IAM Role

# Criação da IAM Role para a EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "ec2_s3_access_role"
  }
}

# Anexação da política de acesso ao S3 na IAM Role
resource "aws_iam_role_policy" "s3_access" {
  name   = "s3_access_policy"
  role   = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:GetObject",
        "s3:PutObject"
      ]
      Effect   = "Allow"
      Resource = "${var.s3_bucket_arn}/*"
    }]
  })
}

# Criação do perfil de instância para a IAM Role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# Criação do Security Group para a EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security Group for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["192.168.1.0/24"]
  }

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Outbound traffic allowed"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_security_group"
  }
}

# Criação da instância EC2
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "MinhaInstanciaEC2"
  }
}

# Outputs da EC2
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
