# 🚀 Infraestructura Web Autoescalable en AWS con Terraform (IaC)

## 🧭 Introducción
Proyecto personal de automatización cloud que demuestra el despliegue de una arquitectura web escalable en AWS mediante Terraform, siguiendo buenas prácticas DevOps e IaC.  

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

## 🧩 Parte 1 — Arquitectura y Componentes de la Infraestructura

### 🏗️ Arquitectura general

La infraestructura implementada con Terraform sigue una **arquitectura modular y escalable en AWS**, diseñada para ofrecer **alta disponibilidad, balanceo de carga y automatización completa del ciclo de vida de las instancias**.

El sistema se compone de los siguientes elementos:

- **Application Load Balancer (ALB):** distribuye el tráfico HTTP entrante entre las instancias EC2 activas.
- **Auto Scaling Group (ASG):** garantiza que siempre haya entre 2 y 3 instancias disponibles, ajustando la capacidad según la carga.
- **Launch Configuration:** define la plantilla base de las instancias EC2 (tipo de máquina, AMI, script de arranque, etc.).
- **Security Groups:** controlan el tráfico de red entrante y saliente, protegiendo tanto al balanceador como a las instancias.
- **Data Sources (VPC y Subnets):** obtienen la red por defecto de AWS para desplegar todos los recursos dentro de una infraestructura existente.

De esta forma, Terraform automatiza el despliegue completo de un **clúster web autoescalable**, reduciendo la intervención manual y asegurando coherencia entre entornos.

---
## 🧩 Parte 2 — Estructura del proyecto Terraform
### 📁 Estructura del proyecto
```bash
terraform-aws-autoscaling-web-cluster/
├── main.tf        # Definición principal de recursos
├── variables.tf   # Variables reutilizables
├── outputs.tf     # Salidas del despliegue (DNS del ALB)
├── README.md      # Documentación del proyecto
```
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

### 🔹 Auto Scaling Group — Escalabilidad automática
Crea el grupo responsable de mantener un número mínimo y máximo de instancias en ejecución:  

#### Qué hace:  
- Mantiene entre 2 y 3 instancias EC2 activas según la carga.  

- Se integra con el Load Balancer mediante el Target Group.

- Realiza comprobaciones de estado (health checks) gestionadas por el ALB.

- Propaga etiquetas (tags) para identificar los servidores desplegados.
  
```hcl
resource "aws_autoscaling_group" "exampleLAJP" {
  launch_configuration = aws_launch_configuration.exampleLAJP.name
  vpc_zone_identifier  = data.aws_subnets.default.ids
  target_group_arns    = [aws_lb_target_group.asgLAJP.arn]
  health_check_type    = "ELB"

  min_size = 2
  max_size = 3

  tag {
    key                 = "Name"
    value               = "terraform-asg-example-LAJP"
    propagate_at_launch = true
  }
}

```


### 🔹 Security Group Instancia — Control de tráfico

Define las reglas de red que permiten el acceso HTTP y la comunicación entre los componentes:

#### Qué hace:

- Permite tráfico HTTP (puerto 80) desde cualquier dirección IP pública (solo para demostración).

- Autoriza todo el tráfico saliente para que las instancias puedan comunicarse con Internet.

- Se asocia tanto al Load Balancer como a las instancias EC2 para habilitar el flujo correcto de datos.

```hcl
  resource "aws_security_group" "instanceLAJP" {
  name = "instance-sg-LAJP"

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

```

### 🔄 Resumen visual del flujo  
El balanceador reparte las peticiones entrantes entre las instancias EC2 activas.  
El grupo de autoescalado lanza o elimina instancias según la carga y los health checks definidos.  

```bash

        ┌──────────────────────────────┐
        │        Usuario final         │
        └──────────────┬───────────────┘
                       │ HTTP (puerto 80)
             ┌─────────▼─────────┐
             │ Application Load  │
             │    Balancer (ALB) │
             └─────────┬─────────┘
                       │
              ┌────────▼────────┐
              │ Auto Scaling    │
              │ Group (ASG)     │
              └────────┬────────┘
                       │
         ┌─────────────▼─────────────┐
         │  EC2 Instances (Apache)   │
         │  Servidor Web dinámico    │
         └───────────────────────────┘

```
## ⚙️ Parte 3 — Recursos Avanzados y Flujo de Red

### 🌐 Módulo VPC y Subredes

El proyecto utiliza los recursos de red existentes en la **VPC por defecto** de AWS, lo que simplifica la infraestructura y evita la creación manual de redes y subredes nuevas.  
Terraform obtiene esta información mediante **bloques de tipo `data`**, que consultan (pero no crean) recursos ya disponibles en la cuenta.

#### Qué hace:
- Obtiene el ID de la VPC por defecto (aws_vpc.default.id).
- Recupera las subredes disponibles dentro de esa VPC en distintas zonas de disponibilidad.
- Permite que otros módulos (como el Auto Scaling Group o el Load Balancer) utilicen esta red existente.

```hcl
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}
```

### ⚖️ Módulo Load Balancer  

Este módulo crea un Application Load Balancer (ALB) que distribuye las solicitudes HTTP entre las instancias del grupo de autoescalado.  
Además, implementa reglas de escucha y comprobaciones de estado (health checks) para garantizar la disponibilidad del sistema.  

#### Qué hace:

- Crea un balanceador de tipo Application (nivel 7 – HTTP/HTTPS).
- Se asocia a las subredes obtenidas del módulo anterior.
- Aplica un grupo de seguridad dedicado para controlar el tráfico entrante y saliente.

```hcl
resource "aws_lb" "exampleLAJP" {
  name               = var.alb_name
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.albLAJP.id]
}

```


### ⚖️ Listener (Regla de escucha) 
El Listener es el componente que recibe las peticiones entrantes en el puerto 80 (HTTP) y las dirige al grupo de destino correspondiente.  

#### Qué hace:

- Escucha tráfico HTTP en el puerto 80.
- Si no se cumple ninguna regla específica, devuelve una respuesta 404 simple.
- Permite añadir posteriormente reglas personalizadas (listener rules) para manejar rutas específicas o servicios adicionales.

```hcl
resource "aws_lb_listener" "httpLAJP" {
  load_balancer_arn = aws_lb.exampleLAJP.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

```

### 🎯 Target Group (Grupo de destino)

Define el conjunto de instancias EC2 hacia las que el ALB enviará las solicitudes.  
También configura los health checks para supervisar el estado de cada instancia. 

#### Qué hace:

- Enruta el tráfico HTTP hacia las instancias EC2 del Auto Scaling Group.
- Realiza comprobaciones periódicas en la URL raíz (/) esperando una respuesta 200 OK.
- Si una instancia falla el chequeo, deja de recibir tráfico hasta recuperarse.

```hcl
resource "aws_lb_target_group" "asgLAJP" {
  name     = var.alb_name
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 75
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

```

### 🔁 Listener Rule (Regla de enrutamiento)

Esta regla conecta el Listener del ALB con el grupo de destino (Target Group) definido anteriormente.  
Se aplica a todas las rutas (path_pattern = "*") y reenvía las peticiones al ASG.  

#### Qué hace:
- listener_arn: vincula la regla al listener HTTP principal.
- priority: determina el orden en que se aplican las reglas (menor valor = mayor prioridad).
- action: reenvía las peticiones al Target Group.
```hcl
resource "aws_lb_listener_rule" "asgLAJP" {
  listener_arn = aws_lb_listener.httpLAJP.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asgLAJP.arn
  }
}
```
El resultado es un flujo continuo:
Cliente → ALB → Listener → Target Group → Instancias EC2  



### 🔐 Módulo Security Group del ALB
Crea un grupo de seguridad específico para el Load Balancer, permitiendo tráfico HTTP público y salida completa hacia Internet.   

#### Qué hace:  
- Entrada (Ingress): habilita solicitudes HTTP en el puerto 80 desde cualquier IP.
- Salida (Egress): permite que el ALB se comunique con las instancias EC2 y otros servicios de AWS.
- Este Security Group complementa al de las instancias, garantizando una comunicación segura entre ambos.
- 
```hcl
resource "aws_security_group" "albLAJP" {
  name = var.alb_security_group_name

  # Permite tráfico HTTP entrante
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite todo el tráfico saliente
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```


### 🧹 Liberación de recursos
Al finalizar las pruebas o la demostración, es fundamental eliminar todos los recursos creados para evitar costos innecesarios.  
Terraform lo hace de forma controlada con el siguiente comando:  

#### Recomendaciones:
- Verifica que no existan errores durante la ejecución.
- Asegúrate de haber obtenido las capturas o el DNS del balanceador antes de destruir la infraestructura.
- Este proceso eliminará automáticamente el ALB, las instancias EC2, los grupos de seguridad y el ASG.

```hcl
terraform destroy
```


### 🔄 Resumen del flujo completo

```bash
1️⃣ El usuario ejecuta "terraform apply"
2️⃣ Terraform crea los recursos en AWS (VPC, SG, EC2, ALB, ASG)
3️⃣ El Application Load Balancer recibe peticiones HTTP (puerto 80)
4️⃣ Las distribuye al grupo de Auto Scaling (EC2 instances)
5️⃣ Los health checks garantizan la disponibilidad continua
6️⃣ El tráfico se balancea de forma automática entre zonas de disponibilidad
7️⃣ "terraform destroy" elimina todos los recursos de forma segura
```


💼 Este proyecto refleja el despliegue automatizado de una arquitectura web escalable y segura en AWS, gestionada íntegramente mediante Terraform.

### 📤 Resultados del despliegue
Al acceder al DNS, se muestra la página web servida por Apache instalada automáticamente en las instancias EC2.  
```hlc
Outputs:

alb_dns_name = "alb-LAJP-123456789.us-east-1.elb.amazonaws.com"
```




