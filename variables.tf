variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "db_instance_class" {
  description = "O tipo da instância do banco de dados"
  type        = string
  default     = "db.t3.micro"  # ou "db.t3.medium", conforme o valor que deseja usar
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "lab-db"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "main"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  default     = "lab-password"
}
variable "db_identifier" {
  description = "O identificador da instância RDS"
  type        = string
  default     = "my-db-instance"  # Substitua pelo valor padrão desejado, se necessário
}

