resource "aws_key_pair" "private" {
  key_name   = var.appserver_config.key_name
  public_key = file(var.appserver_config.public_key_path)
  tags = {
    CreatedBy = "terraform"
  }

}

data "aws_ami" "default_ami" {
  most_recent = true
  

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnet" "web" {
  filter {
    name   = "tag:Name"
    values = [var.appserver_config.web_subnet]
  }

  

  depends_on = [
    aws_vpc.vpc_ntier,
  aws_subnet.subnets]
}

resource "aws_instance" "appserver" {
  ami                         = data.aws_ami.default_ami.id
  associate_public_ip_address = true
  instance_type               = var.appserver_config.instance_type
  key_name                    = var.appserver_config.key_name
  # security_groups = [aws_security_group.webnsg]
  subnet_id              = data.aws_subnet.web.id
  vpc_security_group_ids = [aws_security_group.webnsg.id]

  tags = {
    Name = "appserver"
  }

  depends_on = [
    data.aws_ami.default_ami,
    aws_vpc.vpc_ntier,
    aws_subnet.subnets,
    aws_security_group.webnsg
  ]

}