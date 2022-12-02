#creating VPC for dev env
resource "aws_vpc" "cgvpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.envname}-vpc"
  }
}

# SUBNET CREATION
#Public Subnet
resource "aws_subnet" "pubsubnet" {
  vpc_id     = aws_vpc.cgvpc.id
  cidr_block = var.pubsubnet
  availability_zone = var.azs
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.envname}-pubsubnet"
  }
}

#Private Subnet
resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.cgvpc.id
  cidr_block = var.privatesubnet
  availability_zone = var.azs

  tags = {
    Name = "${var.envname}-privatesubnet"
  }
}

#Creating Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.cgvpc.id

  tags = {
    Name = "${var.envname}-igw"
  }
}

#Creating EIP and Nat Gateway
resource "aws_eip" "nateip" {
  vpc = true
  tags = {
    Name = "${var.envname}-nateip"
  }    
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.pubsubnet.id

  tags = {
    Name = "${var.envname}-natgw"
  }
}

#Creating ROUTE Tables for Public, Private and Data Subnets
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.cgvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.envname}-publicroute"
  }
}

resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.cgvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${var.envname}-privateroute"
  }
}

#Associate Route to Subnets
#Public Route
resource "aws_route_table_association" "pubsubassociation" {
  subnet_id      = aws_subnet.pubsubnet.id
  route_table_id = aws_route_table.publicroute.id
}

#Private Route
resource "aws_route_table_association" "privsubassociation" {
  subnet_id      = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.privateroute.id
}
