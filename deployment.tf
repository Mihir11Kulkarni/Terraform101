resource "aws_instance" "terraform_for_python" {
  provisioner "file" {
    source = "pythondeployment/django-todo-develop"
    destination = "/temp/django-todo-develop"
    
  }
  provisioner "remote-exec" {
    on_failure = continue
    scripts = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = ""
  }
  tags = {
    name = "for pyhton Deployment"
  }
  ami                    = "ami-06ca3ca175f37dd66"
  key_name               = "Mihirlocal"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_for_python.id]
  user_data              = file("${path.module}/script.sh")

}

resource "aws_security_group" "terraform_for_python" {
  name        = "terraform_for_python"
  description = "Allow HTTPS inbound traffic"
  dynamic "ingress" {
    for_each = [443, 22, 8000, 3389]
    iterator = port1
    content {
      description = "ports for VPC"
      from_port   = port1.value
      to_port     = port1.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
output "ip_print" {
  value = "${aws_instance.terraform_for_python.public_ip}:8000"
}

######################################################################################
resource "aws_instance" "terraform_for_python" {
  tags = {
    name = "for pyhton Deployment"
  }
  ami                    = "ami-06ca3ca175f37dd66"
  key_name               = "Mihirlocal"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_for_python.id]
  user_data              = filebase64("./script.sh")
}
resource "aws_security_group" "terraform_for_python" {
  name        = "terraform_for_python"
  description = "Allow HTTPS inbound traffic"
  dynamic "ingress" {
    for_each = [443, 22, 8000, 3389, 80]
    iterator = port1
    content {
      description = "ports for VPC"
      from_port   = port1.value
      to_port     = port1.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
output "ip_print" {
  value = "${aws_instance.terraform_for_python.public_ip}:8000"
}













