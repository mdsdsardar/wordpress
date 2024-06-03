# Data Source for Security Groups
data "aws_security_group" "sg1" {
  filter {
    name   = "group-name"
    values = ["wp-vpc-sg"] # Replace with your first security group name
  }
}

data "aws_security_group" "sg2" {
  filter {
    name   = "group-name"
    values = ["ec2-rds-2"] # Replace with your second security group name
  }
}


#Existing Security Group
data "aws_security_group" "example" {
  name = "rds-ec2-2" # Replace with your security group name
}

#Existing Subnet Group
data "aws_db_subnet_group" "example" {
  name = "wp-db-subnet" # Replace with your subnet group name
}
