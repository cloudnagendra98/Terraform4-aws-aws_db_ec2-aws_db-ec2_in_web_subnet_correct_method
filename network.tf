resource "aws_vpc" "vpc_ntier" {
  cidr_block = var.vpc_cidr_range

  tags = {
    Name = local.name
  }

}

resource "aws_subnet" "subnets" {
  count             = length(var.subnet_names)
  vpc_id            = aws_vpc.vpc_ntier.id
  cidr_block        = cidrsubnet(var.vpc_cidr_range, 8, count.index)
  availability_zone = var.subnet_azs[count.index]

  tags = {
    Name = var.subnet_names[count.index]
  }

  depends_on = [
    aws_vpc.vpc_ntier
  ]

}



data "aws_route_table" "default" {
  #subnet_id = 
  vpc_id = aws_vpc.vpc_ntier.id

  depends_on = [
    aws_vpc.vpc_ntier
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_ntier.id

  tags = {
    Name = "ntier-igw"
  }

}

resource "aws_route" "route_vpc_igw" {
  route_table_id         = data.aws_route_table.default.id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [
    aws_vpc.vpc_ntier,
    data.aws_route_table.default,
  aws_internet_gateway.igw]

}