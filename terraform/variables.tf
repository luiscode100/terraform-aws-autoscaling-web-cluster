variable "server_port" {
  description = "Puerto de escucha para el servidor web y el ALB"
  type        = number
  default     = 80
}

variable "instance_security_group_name" {
  description = "Nombre del Security Group para las instancias EC2"
  type        = string
  default     = "instance-sg-LAJP"
}

variable "alb_security_group_name" {
  description = "Nombre del Security Group para el Load Balancer"
  type        = string
  default     = "alb-sg-LAJP"
}

variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = "alb-LAJP"
}
