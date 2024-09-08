# Criar a VPC
resource "aws_vpc" "lab_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
}

# Criar Sub-rede Pública
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "us-west-2a"
}

# Criar Sub-rede Privada
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-west-2a"
}

# Criar o Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id
}

# Criar a Route Table para a sub-rede pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associar a Route Table à sub-rede pública
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Criar o NAT Gateway
resource "aws_eip" "nat_eip" {
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# Criar a Route Table para a sub-rede privada
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

# Associar a Route Table à sub-rede privada
resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Criar o Security Group para o Web Server
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.lab_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criar o Security Group para o RDS
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.lab_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criar a Instância EC2 (Web Server)
resource "aws_instance" "web_server" {
  ami           = "ami-0abcdef1234567890"  # Amazon Linux 2 AMI ID (exemplo)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd mysql php
              wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1/267-lab-NF-build-vpc-web-server/s3/lab-app.zip
              unzip lab-app.zip -d /var/www/html/
              chkconfig httpd on
              service httpd start
              EOF

  tags = {
    Name = "Web Server 1"
  }
}

# Criar o Grupo de Sub-redes para o RDS
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id]

  tags = {
    Name = "DB Subnet Group"
  }
}

# Criar a Instância RDS
resource "aws_db_instance" "lab_db" {
  identifier              = var.db_identifier  # Nome da instância RDS
  engine                  = "mysql"
  instance_class          = var.db_instance_class
  allocated_storage       = 20
  db_name                 = var.db_name  # Nome do banco de dados dentro da instância
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  multi_az                = true
  storage_type            = "gp2"
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  skip_final_snapshot     = true
  parameter_group_name    = "default.mysql8.0"
}
