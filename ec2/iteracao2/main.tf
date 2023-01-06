variable "environment" {
  description = ""
  type = string
}

variable "region" {
  description = ""
  type = string
}

variable "instance_type" {
  description = ""
  type = string
}

locals {
  name-suffix = "${var.region}-${var.environment}"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "public_http_sg" {
  name      = "public_http_sg-${local.name-suffix}"

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "tcp"
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Environment" = var.environment
    "visibility"  = "public"
  }
}

resource "aws_instance" "apache2_server" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.public_http_sg.id]
  user_data = "${file("user_data.sh")}"
  tags = {
    env   = var.environment
    Name  = "ec2-${local.name-suffix}"
  }
}


output "ip_address" {
  value = aws_instance.apache2_server.public_ip
}