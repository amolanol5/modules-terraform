# Módulos Terraform
Modulos útlies para ambientes de desarrollo y probar funcionalidades.

- vpn-natgateway
- lambda-edge

pasos para usar los módulos: 

### vpn-natgateway

1. Descargar el repositorio
2. crear una carpeta llamada project

> modules

> project

3. llamar el módulo de vpn-natgateway

```tf
module "vpc_test" {
  source = "../modules/vpc-natgateway"
  enable_nat_gateway = true
}
```

4. crear los archivos tf necesarios.