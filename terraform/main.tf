terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}


resource "aws_launch_configuration" "exampleLAJP" {
  image_id = "ami-08982f1c5bf93d976" # Amazon Linux 2 AMI (example for us-east-1)
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.instanceLAJP.id]

  user_data = <<-EOF
              #!/bin/bash
               sudo yum update -y
               sudo yum install -y httpd
               sudo systemctl start httpd
               sudo systemctl enable httpd
               echo "¡Hola desde mi EC2 con Terraform!" | sudo tee /var/www/html/index.html
             EOF

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "exampleLAJP" {
  launch_configuration = aws_launch_configuration.exampleLAJP.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asgLAJP.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 3

  tag {
    key                 = "Name"
    value               = "terraform-asg-example-LAJP"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instanceLAJP" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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

resource "aws_lb" "exampleLAJP" {

  name               = var.alb_name

  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.albLAJP.id]
}

resource "aws_lb_listener" "httpLAJP" {
  load_balancer_arn = aws_lb.exampleLAJP.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "asgLAJP" {

  name = var.alb_name

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

resource "aws_security_group" "albLAJP" {

  name = var.alb_security_group_name

  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
