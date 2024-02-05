resource "aws_vpc" "vpc1" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.prefix}-vpc"
    }
}
module "subnet1_module" {
   source = "./modules/subnet"
   vpc_id = aws_vpc.vpc1.id
   subnet_cidr_block = var.subnet_cidr_block 
   zone = var.zone
   sub_prefix = var.prefix
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