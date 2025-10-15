# 🚀 Infraestructura Web Autoescalable en AWS con Terraform (IaC)

## 🧭 Descripción general

Este proyecto demuestra la aplicación de los principios de **Infraestructura como Código (IaC)** mediante **Terraform** para desplegar de forma automática una **infraestructura web escalable en AWS**.  
El sistema implementa un entorno completo compuesto por **instancias EC2**, un **Application Load Balancer (ALB)** y un **Auto Scaling Group (ASG)**, todo definido, versionado y gestionado mediante código declarativo.

A través del enfoque IaC, el proceso de despliegue se vuelve **reproducible, auditable y consistente**, permitiendo crear entornos idénticos (desarrollo, pruebas o producción) con un solo comando.  
La arquitectura se alinea con los principios **cloud-native** y las buenas prácticas **DevOps**, priorizando la automatización, la escalabilidad y la eficiencia operativa.

---

## 🎯 Objetivos del proyecto

- **Automatizar el despliegue de infraestructura.**  
  Utilizar Terraform para aprovisionar y administrar recursos en AWS a través de código declarativo.

- **Implementar una arquitectura web escalable y balanceada.**  
  Desplegar un conjunto de instancias EC2 detrás de un balanceador de carga de aplicación (ALB), gestionadas dinámicamente por un grupo de autoescalado (ASG).

- **Garantizar la seguridad en el acceso.**  
  Configurar grupos de seguridad para permitir tráfico HTTP (puerto 80) y controlar la comunicación entre los distintos componentes.

- **Aplicar buenas prácticas de IaC.**  
  Separar variables, salidas y configuraciones principales para mantener un código modular, reutilizable y fácil de mantener.

- **Demostrar competencias en DevOps y Cloud Engineering.**  
  Mostrar dominio del ciclo de vida de la infraestructura, el control de versiones y la automatización de entornos.

---

## 🧰 Tecnologías principales

| Herramienta / Servicio | Propósito |
|-------------------------|-----------|
| **Terraform** | Herramienta IaC para definir y desplegar infraestructura en la nube |
| **AWS EC2** | Instancias de cómputo para el clúster web |
| **AWS ALB (Application Load Balancer)** | Distribución del tráfico HTTP entre instancias |
| **AWS Auto Scaling Group (ASG)** | Escalado automático de capacidad según la carga |
| **AWS Security Groups** | Control del tráfico de red entrante y saliente |
| **Amazon Linux 2** | Entorno base del servidor web |

---

## ⚙️ ¿Por qué Terraform?

Terraform permite describir infraestructuras de forma **declarativa y versionable**, como si se tratara de código fuente.  
Su sistema de **gestión de estado (state management)** calcula las diferencias entre la configuración actual y el estado deseado, aplicando solo los cambios necesarios de forma segura y predecible.

Esto lo convierte en una herramienta esencial en flujos de trabajo **DevOps y Cloud**, al reducir errores manuales, mejorar la trazabilidad de los cambios y fomentar la automatización total de los despliegues.

---

## 🌎 Alcance del proyecto

Este proyecto sirve como ejemplo práctico para:

- Mostrar habilidades en **automatización cloud e Infraestructura como Código**.  
- Integrar proyectos **DevOps y AWS** dentro de un portfolio profesional.  
- Presentar una **demostración técnica en entrevistas** sobre despliegues automatizados.  
- Reutilizar la estructura como plantilla base para entornos productivos.

---

## 🧩 Próximas secciones

1. **Arquitectura general del sistema** — cómo se conectan los componentes de AWS.  
2. **Estructura del proyecto Terraform** — descripción de los archivos `.tf`.  
3. **Recursos y módulos de Terraform** — explicación detallada de cada bloque.  
4. **Flujo de despliegue** — comandos `init`, `plan`, `apply` y `destroy`.  
5. **Resultados y salida del DNS** — validación del servicio web desplegado.

---

# 🧩 Parte 2 — Arquitectura y Componentes de la Infraestructura

## 🏗️ Arquitectura general

La infraestructura implementada con Terraform sigue una **arquitectura modular y escalable en AWS**, diseñada para ofrecer **alta disponibilidad, balanceo de carga y automatización completa del ciclo de vida de las instancias**.

El sistema se compone de los siguientes elementos:

- **Application Load Balancer (ALB):** distribuye el tráfico HTTP entrante entre las instancias EC2 activas.
- **Auto Scaling Group (ASG):** garantiza que siempre haya entre 2 y 3 instancias disponibles, ajustando la capacidad según la carga.
- **Launch Configuration:** define la plantilla base de las instancias EC2 (tipo de máquina, AMI, script de arranque, etc.).
- **Security Groups:** controlan el tráfico de red entrante y saliente, protegiendo tanto al balanceador como a las instancias.
- **Data Sources (VPC y Subnets):** obtienen la red por defecto de AWS para desplegar todos los recursos dentro de una infraestructura existente.

De esta forma, Terraform automatiza el despliegue completo de un **clúster web autoescalable**, reduciendo la intervención manual y asegurando coherencia entre entornos.

---

## ⚙️ Flujo de funcionamiento

1. El **usuario ejecuta** los comandos `terraform init`, `plan` y `apply`.  
2. Terraform **lee las configuraciones declarativas** de los archivos `.tf`.  
3. Se **crea la infraestructura en AWS** en el orden adecuado:
   - Primero los **grupos de seguridad** y los **recursos de red (data sources)**.
   - Luego las **instancias EC2**, el **Auto Scaling Group** y el **Load Balancer**.
4. El **Load Balancer** distribuye el tráfico HTTP (puerto 80) entre las instancias activas.
5. Si una instancia falla, el **Auto Scaling Group** lanza automáticamente otra para mantener la capacidad mínima definida.
6. Al finalizar, el comando `terraform destroy` elimina todos los recursos de manera controlada.

---

## 🧱 Componentes principales de Terraform

### 🔹 Provider — Configuración del entorno AWS

Define el proveedor de servicios en la nube y la región donde se desplegarán los recursos:

```hcl
provider "aws" {
  region = "us-east-1"
}
```
Terraform se conecta a AWS utilizando las credenciales almacenadas en el archivo local ~/.aws/credentials, evitando incluir datos sensibles en el código fuente.  

### 🔹 Data Sources — VPC y Subnets  

Consultan información de la VPC por defecto y sus subredes dentro de la región seleccionada:

```hcl
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

```
Propósito: reutilizar la red existente en AWS sin necesidad de crear una nueva infraestructura de red, garantizando compatibilidad y simplicidad.

### 🔹 Launch Configuration — Plantilla base de instancias EC2  
Define la configuración base de cada instancia que se desplegará dentro del grupo de autoescalado:  

#### Qué hace:

- Usa una AMI oficial de Amazon Linux 2.

- Instala y configura Apache automáticamente.

- Crea un archivo index.html como mensaje de prueba.

- La cláusula lifecycle evita interrupciones al actualizar el entorno, creando las nuevas instancias antes de destruir las anteriores.

```hcl
resource "aws_launch_configuration" "exampleLAJP" {
  image_id        = "ami-08982f1c5bf93d976"  # Amazon Linux 2
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.instanceLAJP.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "¡Hola desde mi EC2 con Terraform!" > /var/www/html/index.html
            EOF

  lifecycle {
    create_before_destroy = true
  }
}

```





























