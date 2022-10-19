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

output "key_pair_id" {
  value = aws_key_pair.deployer.key_pair_id
}