
# Create Internet-facing ALB
resource "aws_lb" "example" {
  name               = "wordpress-alb"
  load_balancer_type = "application"
  subnets            = ["subnet-0b5b2748dfe6a22fd", "subnet-0526ae9cfe1fca3d3"] # Replace with your public subnets
  security_groups    = [data.aws_security_group.sg1.id]
}


# Create a Load Balancer listener
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn # Replace with your ALB ARN
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn # Replace with your TG ARN
  }
}

