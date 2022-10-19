# Ejemplos de Terraform

## Guía de pasos
- cp .env.examples .env
- cp terraform.tfvars.example terraform.tfvars
- Modificar el .env para meter las credenciales
- Modificar el terraform.tfvars para meter la rura al id_rsa.pub
- source .env
- terraform init
- terraform plan
- terraform apply

# Eliminar los recursos
- terraform destroy