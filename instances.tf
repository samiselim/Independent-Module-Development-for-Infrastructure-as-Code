data "aws_ami" "aws_image_latest" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240131.0-x86_64-gp2"]
    }

}

resource "aws_instance" "instance1" {
    # ami = "ami-0bf160d8f27d39442"
    ami = data.aws_ami.aws_image_latest.id
    instance_type = var.instance_type

    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.security_group1.id]
    availability_zone = var.zone

    associate_public_ip_address = true 
    key_name = aws_key_pair.ssh_key.key_name

    connection {
        type = "ssh"
        host =self.public_ip
        user = "ec2-user"
        private_key = file(var.private_key_location)
    }
    provisioner "file" {
        source = "entry_script.sh"
        destination = "/home/ec2-user/cp_script.sh"

        # connection {
        #     type = "ssh"
        #     host =anouther server .public_ip
        #     user = "ec2-user"
        #     private_key = file(var.private_key_location)
        # }
    }   
    provisioner "remote-exec" {
        inline = [ 
            "export ENV=demo1",
            "mkdir hello_dir"
         ]
        # script = file("cp_script.sh")
    }
     provisioner "local-exec" {
        command = "echo ${self.public_ip} > out.txt"
     }


    # user_data = file("entry_script.sh")

    tags = {
      Name: "${var.prefix}-server"
    }

}
resource "aws_key_pair" "ssh_key" {
    key_name = "server-key"
    public_key = "${file(var.public_key_location)}"
}


output "image" {
    value = data.aws_ami.aws_image_latest.name
}

output "public_ip" {
    value = aws_instance.instance1.public_ip
}