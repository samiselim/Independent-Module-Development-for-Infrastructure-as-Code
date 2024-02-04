resource "aws_vpc" "vpc1" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.prefix}-vpc"
    }
}
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.zone
  tags = {
    Name: "${var.prefix}-subnet"
  }
}

resource "aws_internet_gateway" "gate_way1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name: "${var.prefix}-igw"
    }
}

resource "aws_route_table" "route_table1" {
    vpc_id = aws_vpc.vpc1.id

    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.gate_way1.id
    }
    tags = {
      Name: "${var.prefix}-rtb"
    }
}
resource "aws_route_table_association" "rtb_association1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table1.id
}
resource "aws_security_group" "security_group1" {
    name = "${var.prefix}-sg"
    vpc_id = aws_vpc.vpc1.id
    ingress {
        # here ther is from and to because you can define a range of ports ﻻ
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.ssh_ip]
    }
    ingress  {
        # here ther is from and to because you can define a range of ports ﻻ
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    egress {
        from_port = 0
        to_port = 0 
        protocol = "-1"  #any protocol
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
      Name: "${var.prefix}-sg"
    }
}