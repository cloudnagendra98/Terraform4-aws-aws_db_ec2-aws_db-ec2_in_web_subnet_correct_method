variable "vpc_cidr_range" {
  type        = string
  default     = "10.0.0.0/16"
  description = "This is vpc cidr range"

}

# variable "subnet_cidr_range" {
#     type = string
#     default = "10.0.%g.0/24" 
#     description = "These are subnet cidr ranges"
# }

variable "subnet_names" {
  type        = list(string)
  default     = ["web1", "web2", "app1", "app2", "db1", "db2"]
  description = "These are subnet names"

}

variable "db_subnet_names" {
  type        = list(string)
  default     = ["db1", "db2"]
  description = "These are db subnet names"

}

variable "subnet_azs" {
  type        = list(string)
  default     = ["us-west-1b", "us-west-1c", "us-west-1b", "us-west-1c", "us-west-1b", "us-west-1c"]
  description = "These are availability zones"
}

# variable "web_subnet" {
#   type = string
#   default = "web1"
#   description = "This is web subnet"

# }

variable "webnsg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      protocol   = string
      from_port  = number
      to_port    = number
      cidr_block = string
    }))
  })
  default = {
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
}

variable "appnsg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      protocol   = string
      from_port  = number
      to_port    = number
      cidr_block = string
    }))
  })
  default = {
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
}

variable "dbnsg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      protocol   = string
      from_port  = number
      to_port    = number
      cidr_block = string
    }))
  })
  default = {
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
}

variable "db_info" {
  type = object({
    allocated_storage = number
    db_name           = string
    engine            = string
    engine_version    = string
    instance_class    = string
    username          = string
    password          = string
    identifier        = string

  })
  default = {
    allocated_storage = 20
    db_name           = "emp"
    engine            = "mysql"
    engine_version    = "8.0"
    instance_class    = "db.t3.micro"
    username          = "user"
    password          = "rootroot"
    identifier        = "mydbfromtf"

  }

}

variable "appserver_config" {
  type = object({
    key_name        = string
    public_key_path = string
    instance_type   = string
    web_subnet      = string

  })
  default = {
    key_name        = "ntier"
    public_key_path = "~/.ssh/id_rsa.pub"
    instance_type   = "t2.micro"
    web_subnet      = "web1"
  }
}