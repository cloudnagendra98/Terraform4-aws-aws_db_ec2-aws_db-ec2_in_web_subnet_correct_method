data "aws_subnets" "db" {
  filter {
    name   = "tag:Name"
    values = var.db_subnet_names # insert values here
  }

  depends_on = [
    aws_subnet.subnets
  ]
}


resource "aws_db_subnet_group" "ntier" {
  name       = "ntier"
  subnet_ids = data.aws_subnets.db.ids

  tags = {
    Name = "ntier"
  }

  depends_on = [
    aws_subnet.subnets,
  data.aws_subnets.db]

}

resource "aws_db_instance" "ntier" {
  allocated_storage      = var.db_info.allocated_storage
  db_name                = var.db_info.db_name
  engine                 = var.db_info.engine
  engine_version         = var.db_info.engine_version
  instance_class         = var.db_info.instance_class
  username               = var.db_info.username
  password               = var.db_info.password
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.ntier.name
  identifier             = var.db_info.identifier
  vpc_security_group_ids = [aws_security_group.dbnsg.id]

  depends_on = [
    aws_db_subnet_group.ntier,
    aws_vpc.vpc_ntier,
    aws_subnet.subnets

  ]

}