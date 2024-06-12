resource "aws_rds_cluster" "example" {
  cluster_identifier        = "wordpress-db"
  availability_zones        = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  engine                    = "mysql"
  db_cluster_instance_class = "db.c6gd.medium"
  storage_type              = "gp3"
  allocated_storage         = 20
  database_name             = "wordpress"
  master_username           = "admin"
  master_password           = "12345678"
  db_subnet_group_name      = data.aws_db_subnet_group.example.name
  vpc_security_group_ids    = [data.aws_security_group.example.id]
  skip_final_snapshot       = true
  apply_immediately         = true
}


# aws_rds_cluster.example.endpoint = important value.
