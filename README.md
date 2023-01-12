# terraform_githubactions
- para fazer uso do workspace remoto do app.terraform.io
```
 terraform init -backend-config=dev.hcl
```
- para mudar de workspace
```
terraform init -backend-config=prod.hcl -reconfigure
```
- podemos substituir as variáveis do terraform, seguindo a ordem de prioridade
  - variavel no terraform cloud
  - direto no cli terraform apply -var "type=teste"
  - passando valor no terraform.auto.tfvars
  - valor default no arquivo variables.tf
