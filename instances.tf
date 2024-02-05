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

    subnet_id = module.subnet1_module.subnet_object.id # reference the module called subnet1_module 
    vpc_security_group_ids = [aws_security_group.security_group1.id]
    availability_zone = var.zone

    associate_public_ip_address = true 
    key_name = aws_key_pair.ssh_key.key_name


    user_data = file("entry_script.sh")

    tags = {
      Name: "${var.prefix}-server"
    }

}
resource "aws_key_pair" "ssh_key" {
    key_name = "server-key"
    public_key = "${file(var.public_key_location)}"
}


