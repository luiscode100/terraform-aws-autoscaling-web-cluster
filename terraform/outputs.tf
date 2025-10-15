output "alb_dns_name" {
  description = "DNS publico del ALB"
  value       = aws_lb.exampleLAJP.dns_name
}
