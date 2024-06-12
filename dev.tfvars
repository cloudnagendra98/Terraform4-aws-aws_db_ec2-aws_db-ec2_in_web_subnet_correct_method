vpc_cidr_range  = "10.0.0.0/16"
subnet_names    = ["web1", "web2", "app1", "app2", "db1", "db2"]
db_subnet_names = ["db1", "db2"]
subnet_azs      = ["us-west-1b", "us-west-1c", "us-west-1b", "us-west-1c", "us-west-1b", "us-west-1c"]
#web_subnet = "web1"
webnsg_config = {
  name        = "webnsg"
  description = "This is web security group"
  rules = [{
    type       = "ingress"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = "0.0.0.0/0"
    },
    {
      type       = "ingress"
      protocol   = "tcp"
      from_port  = 22
      to_port    = 22
      cidr_block = "0.0.0.0/0"
    },
    {
      type       = "egress"
      protocol   = "-1"
      from_port  = 0
      to_port    = 65535
      cidr_block = "0.0.0.0/0"
  }]
}

appnsg_config = {
  name        = "appnsg"
  description = "This is app security group"
  rules = [{
    type       = "ingress"
    protocol   = "tcp"
    from_port  = 8080
    to_port    = 8080
    cidr_block = "0.0.0.0/0"
    },
    {
      type       = "ingress"
      protocol   = "tcp"
      from_port  = 22
      to_port    = 22
      cidr_block = "0.0.0.0/0"
    },
    {
      type       = "egress"
      protocol   = "-1"
      from_port  = 0
      to_port    = 65535
      cidr_block = "0.0.0.0/0"
  }]
}

dbnsg_config = {
  name        = "dbnsg"
  description = "This is db security group"
  rules = [{
    type       = "ingress"
    protocol   = "tcp"
    from_port  = 3306
    to_port    = 3306
    cidr_block = "10.0.0.0/16"
    },
    {
      type       = "ingress"
      protocol   = "tcp"
      from_port  = 22
      to_port    = 22
      cidr_block = "0.0.0.0/0"
    },
    {
      type       = "egress"
      protocol   = "-1"
      from_port  = 0
      to_port    = 65535
      cidr_block = "0.0.0.0/0"
  }]
}

db_info = {
  allocated_storage = 20
  db_name           = "emp"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  username          = "user"
  password          = "rootroot"
  identifier        = "mydbfromtf"
}

appserver_config = {
  key_name        = "ntier"
  public_key_path = "~/.ssh/id_rsa.pub"
  instance_type   = "t2.micro"
  web_subnet      = "web1"
}