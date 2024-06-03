#!/bin/bash
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo mv wordpress/* /var/www/html/
sudo chown -R ec2-user:ec2-user /var/www/html/
sudo find /var/www/html/ -type d -exec chmod 755 {} \;
sudo find /var/www/html/ -type f -exec chmod 644 {} \;
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Replace database_name_here and username_here in wp-config.php
sed -i 's/database_name_here/${db_name}/g' /var/www/html/wp-config.php
sed -i 's/username_here/${db_user}/g' /var/www/html/wp-config.php
sed -i 's/password_here/${db_password}/g' /var/www/html/wp-config.php
sed -i 's/localhost/${db_endpoint}/g' /var/www/html/wp-config.php

# Create health-check.php file
echo '<?php' > /var/www/html/health-check.php
echo '// health-check.php' >> /var/www/html/health-check.php
echo 'http_response_code(200);' >> /var/www/html/health-check.php
echo 'echo "Healthy";' >> /var/www/html/health-check.php
