# terraform-aws-autoscaling-web-cluster
Infrastructure as Code project using Terraform to deploy an auto-scaling web cluster on AWS with an Application Load Balancer and security groups configuration

# 🌐 Terraform AWS Infrastructure — Web Cluster Auto-Scaling (IaC)

Este proyecto demuestra la implementación de **Infraestructura como Código (IaC)** mediante **Terraform**, desplegando un **cluster web escalable en AWS** con **balanceador de carga (ALB)** y **auto-escalado (ASG)**.

---

## 🎯 Objetivos

- Aprender el uso de Terraform como herramienta IaC.
- Desplegar automáticamente una infraestructura en AWS.
- Configurar un balanceador de carga (Application Load Balancer).
- Crear un grupo de autoescalado (Auto Scaling Group) con instancias EC2.
- Definir grupos de seguridad para habilitar tráfico HTTP (puerto 80).

---

## 🧩 Estructura del proyecto
```bash
terraform-project/
├── main.tf # Definición principal de recursos
├── variables.tf # Variables globales reutilizables
├── outputs.tf # Salidas del despliegue (DNS del Load Balancer)
└── README.md # Documentación del proyecto
```

- **`main.tf`**: Contiene los recursos principales: EC2, Load Balancer, grupos de seguridad y autoscaling.
- **`variables.tf`**: Centraliza nombres, puertos y otros parámetros modificables.
- **`outputs.tf`**: Expone las salidas útiles (DNS del ALB) tras la ejecución.

---

## ⚙️ Recursos desplegados

| Recurso | Descripción | Identificador |
|----------|--------------|----------------|
| `aws_launch_configuration` | Configura la plantilla base de las instancias EC2 con Apache. | `exampleLAJP` |
| `aws_autoscaling_group` | Mantiene entre 2–3 instancias EC2 activas. | `exampleLAJP` |
| `aws_security_group` | Controla el tráfico entrante/saliente HTTP (puerto 80). | `instanceLAJP`, `albLAJP` |
| `aws_lb` | Application Load Balancer para distribuir tráfico. | `exampleLAJP` |
| `aws_lb_target_group` | Agrupa las instancias EC2 del ASG. | `asgLAJP` |
| `aws_lb_listener` | Recibe peticiones HTTP en el puerto 80. | `httpLAJP` |
| `aws_lb_listener_rule` | Redirige tráfico del ALB hacia el Target Group. | `asgLAJP` |

---

## 🧠 Flujo de trabajo Terraform
Descarga los plugins del proveedor AWS y prepara el entorno.  

1. **Inicialización del entorno**
   ```bash
   terraform init
   ```
2. **Planificación del despliegue**
Muestra los recursos que se crearán (+) o destruirán (–).  
   ```bash
   terraform plan
   ```
3. **Despliegue**
Ejecuta el aprovisionamiento real.
   ```bash
   terraform apply
   ```
4.Destrucción
   ```bash
   terraform destroy
   ```
## 🌍 Configuración del proveedor
El archivo provider define la región y se apoya en las credenciales configuradas localmente con AWS CLI:  
```bash
  provider "aws" {
  region = "us-east-1"
}
```
   
