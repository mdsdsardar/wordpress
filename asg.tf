# Auto Scaling Group with Multiple Subnets and Target Tracking Policy
resource "aws_autoscaling_group" "example_asg" {
  name         = "wordpress-asg"
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  vpc_zone_identifier = ["subnet-0b5b2748dfe6a22fd", "subnet-0526ae9cfe1fca3d3"]

  tag {
    key                 = "Name"
    value               = "wp-instance"
    propagate_at_launch = true
  }
}
