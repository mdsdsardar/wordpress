# Launch Template
resource "aws_launch_template" "example" {
  name         = "wordpress-template"
  description   = "Launch Template"
  image_id      = "ami-0408b6617d009c75d" # Replace with your AMI ID
  instance_type = "t2.micro" # Specify your instance type
  key_name      = "main" # Replace with your key pair name

  network_interfaces {
    security_groups = [data.aws_security_group.sg1.id, data.aws_security_group.sg2.id]
    associate_public_ip_address = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20
      volume_type = "gp3"
      delete_on_termination = true
      encrypted             = false
    }
  }
    tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "wordpress-instance"
    }
  }
  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    db_name     = "wordpress",
    db_user     = "admin",
    db_password = "12345678",
    db_endpoint = aws_rds_cluster.example.endpoint
  }))
}


