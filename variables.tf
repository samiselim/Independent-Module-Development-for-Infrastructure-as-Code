variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "zone" {}
variable "ssh_ip" {}
variable "public_key_location" {}

variable "instance_type" {
    default = "t2.micro"
}
variable "prefix" {
    default = "demo1"
}

variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
    default = "10.0.0.0/24"
}
