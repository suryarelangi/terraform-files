resource "aws_vpc" "myvpc" {
tags = {
Name = "vpc1"
}
cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
enable_dns_hostnames = "true"
}

resource "aws_subnet" "subnet1" {
tags = {
Name = "public-subnet"
}
vpc_id = aws_vpc.myvpc.id
cidr_block = "10.0.0.0/24"
availability_zone = "us-east-1a"
map_public_ip_on_launch = "true"
}

resource "aws_subnet" "subnet2" {
tags = {
Name = "private-subnet"
}
cidr_block = "10.0.0.0/24"
vpc_id = aws_vpc.myvpc.id
availability_zone = "us-east-1b"
}

resource "aws_internet_gateway" "myigw" {
tags = {
Name = "igw"
}
vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "rt1" {
tags = {
Name = "public-RT" 
}
vpc_id = aws_vpc.myvpc.id
route {
cidr_block = "10.0.1.0/24"
gateway_id = aws_internet_gateway.myigw.id
}
}

resource "aws_route_table_association" "subnetass" {
subnet_id = aws_subnet.subnet1.id
route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table" "rt2" {
tags = {
Name = "private-RT"
}
vpc_id = aws_vpc.myvpc.id
route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.nat1.id
}
}

resource "aws_route_table_association" "natass" {
subnet_id = aws_subnet.subnet2.id
route_table_id = aws_route_table.rt2.id
}

resource "aws_nat_gateway" "nat1" {
tags = {
Name = "natgateway"
}
subnet_id = aws_subnet.subnet1.id
allocation_id = aws_eip.eip.id
}

resource "aws_eip" "eip" {
domain = "vpc"
}





