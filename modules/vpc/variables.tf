# Declaração das variáveis específicas do módulo VPC

# Bloco CIDR da VPC
variable "cidr_block" {
  description = "Bloco CIDR para a VPC"
  type        = string
}

# Blocos CIDR das sub-redes públicas
variable "public_subnet_cidrs" {
  description = "Blocos CIDR para as sub-redes públicas"
  type        = list(string)
}

# Blocos CIDR das sub-redes privadas
variable "private_subnet_cidrs" {
  description = "Blocos CIDR para as sub-redes privadas"
  type        = list(string)
}

# Zonas de disponibilidade para as sub-redes
variable "availability_zones" {
  description = "Zonas de disponibilidade para as sub-redes"
  type        = list(string)
}