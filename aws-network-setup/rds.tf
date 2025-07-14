resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_rds.id]
}


resource "aws_db_instance" "my_rds" {
  identifier         = "mydbinstance"
  engine             = "postgres"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  db_name            = "appdb"
  username           = "postgres"
  password           = "Postgres123"
  vpc_security_group_ids = [aws_security_group.rds_private_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true
}
