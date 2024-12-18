# Valores das variáveis específicas para o ambiente de produção

aws_region           = "us-east-1"
vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

s3_bucket_name       = "bucket-s3-prod-exemplo"
ec2_ami              = "ami-01816d07b1128cd2d" # ami-linux
ec2_key_name         = "keypair-prod"
candidate_ip         = "192.168.1.1/32" # Substitua pelo seu IP #ip de teste
rds_db_name          = "meubanco-prod"
rds_db_username      = "admin_prod"
rds_db_password      = "senha-super-secreta-prod" # Warning:Preferencialmente, utilizar um gerenciador de segredos
