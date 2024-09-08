![Descrição da Imagem](https://github.com/Lopeswaprojetos/Terrform-AWS-RDS-VPC-EC2/blob/main/infraestrutura.png..png?raw=true)



## Infraestrutura AWS com Terraform


Este projeto demonstra como criar e gerenciar uma infraestrutura na AWS utilizando Terraform.
 A infraestrutura inclui uma VPC (Virtual Private Cloud), subnets públicas e privadas, NAT Gateway, Internet Gateway, instâncias EC2, e uma instância do Amazon RDS para banco de dados, tudo configurado como código.


## Estrutura do Projeto
A infraestrutura criada é composta pelos seguintes componentes:

**VPC (Virtual Private Cloud):** Cria uma rede isolada para hospedar os recursos de forma segura.

**Subnets Públicas e Privadas:** Define subnets para separar os recursos que precisam estar acessíveis pela internet daqueles que devem permanecer privados.

**Internet Gateway:** Permite que as instâncias nas subnets públicas tenham acesso à internet.

**NAT Gateway:** Permite que as instâncias nas subnets privadas acessem a internet de forma segura, sem ficarem diretamente acessíveis.

**Security Groups:** Define regras de firewall para controlar o tráfego de entrada e saída das instâncias.

**EC2 (Elastic Compute Cloud):** Cria instâncias virtuais para hospedar aplicações e gerenciar workloads diversos.

**Amazon RDS (Relational Database Service):** Configura um banco de dados relacional escalável e altamente disponível, com réplicas em subnets privadas para maior segurança e redundância.

## Pré-requisitos
Terraform instalado na máquina.

Uma conta na AWS com permissões suficientes para criar os recursos descritos.

Chave SSH configurada para acessar as instâncias EC2.


## Como Executar
Clone o repositório para a sua máquina local:

Acesse o diretório do projeto:

*https://github.com/Lopeswaprojetos/Terrform-AWS-RDS-VPC-EC2.git*

Inicialize o Terraform:

*terraform init*

Visualize o plano de execução para revisar as mudanças que serão aplicadas:

*terraform plan*

Aplique o plano para provisionar a infraestrutura:

*terraform apply*

Confirme a aplicação digitando *yes* quando solicitado.


## Como Usar
Após a execução bem-sucedida do Terraform, a infraestrutura estará provisionada na AWS.
 Você pode acessar as instâncias EC2 utilizando a chave SSH configurada e utilizar o banco de dados RDS conforme necessário.

## A documentação do código foi gerada automaticamente com o terraform-docs e está disponível abaixo:

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --> <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.66.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.lab_db](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/db_subnet_group) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/eip) | resource |
| [aws_instance.web_server](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/instance) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/route_table) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private_rt_assoc](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_rt_assoc](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/route_table_association) | resource |
| [aws_security_group.db_sg](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/security_group) | resource |
| [aws_security_group.web_sg](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/security_group) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/subnet) | resource |
| [aws_vpc.lab_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.66.0/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-west-2"` | no |
| <a name="input_db_identifier"></a> [db\_identifier](#input\_db\_identifier) | O identificador da instância RDS | `string` | `"my-db-instance"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | O tipo da instância do banco de dados | `string` | `"db.t3.micro"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | `"lab-db"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database master password | `string` | `"lab-password"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database master username | `string` | `"main"` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | Private Subnet CIDR block | `string` | `"10.0.1.0/24"` | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | Public Subnet CIDR block | `string` | `"10.0.0.0/24"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | RDS Endpoint |
| <a name="output_web_server_ip"></a> [web\_server\_ip](#output\_web\_server\_ip) | Public IP of the Web Server |
<!-- END_TF_DOCS -->
