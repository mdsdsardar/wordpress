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

#   user_data = base64encode(<<EOF
# #!/bin/bash
# wget https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz
# sudo mv wordpress/* /var/www/html/
# sudo chown -R ec2-user:ec2-user /var/www/html/
# sudo find /var/www/html/ -type d -exec chmod 755 {} \;
# sudo find /var/www/html/ -type f -exec chmod 644 {} \;
# cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#               # Replace database_name_here and username_here
# sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
# sed -i 's/username_here/admin/g' /var/www/html/wp-config.php
# sed -i 's/password_here/12345678/g' /var/www/html/wp-config.php
# sed -i 's/localhost/example.cluster-czdmyhc4qqhe.ap-south-1.rds.amazonaws.com/g' /var/www/html/wp-config.php

#               # Create health-check.php file
# echo '<?php' > /var/www/html/health-check.php
# echo '// health-check.php' >> /var/www/html/health-check.php
# echo 'http_response_code(200);' >> /var/www/html/health-check.php
# echo 'echo "Healthy";' >> /var/www/html/health-check.php
# EOF
#   )
}


