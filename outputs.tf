output "image" {
    value = data.aws_ami.aws_image_latest.name
}

output "public_ip" {
    value = aws_instance.instance1.public_ip
}