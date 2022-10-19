# Comentario
provider "aws" {
  region = "eu-west-3"
  # secret_key = ""
  # access_key = ""
}

variable "ssh_key_path" {}

# Recurso de clave SSH en AWS
resource "aws_key_pair" "deployer" {
  key_name = "deployer-key-v2"
  public_key = file(var.ssh_key_path)
  tags = {
    Name = "pepesan-ssh"
  }
}

variable "availability_zone" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "vpc-main-v2"
  cidr = "10.0.0.0/16"
  azs = [var.availability_zone]
  private_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnets = ["10.0.100.0/24", "10.0.101.0/24"]
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags = { Terraform = "true", Environment = "dev" }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id = module.vpc.vpc_id
  # ingress
  ingress {
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # egress
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}




output "key_pair_id" {
  value = aws_key_pair.deployer.key_pair_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

