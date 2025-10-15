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
