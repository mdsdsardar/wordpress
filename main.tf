provider "aws" {
  region = "ap-south-1" # Replace with your desired region
}

output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The DNS name of the ALB"
}