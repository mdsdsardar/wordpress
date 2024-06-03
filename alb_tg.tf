
# Create Target Group
resource "aws_lb_target_group" "example" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-038b85c62965959b1" # Replace with your VPC ID

  health_check {
    path                = "/health-check.php"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

# Create Auto Scaling Attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.example_asg.name
  lb_target_group_arn   = aws_lb_target_group.example.arn
}
