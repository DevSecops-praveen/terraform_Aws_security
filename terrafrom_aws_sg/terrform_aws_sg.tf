provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAY6OHVZ5ID7ZLTG7A"
  secret_key = "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"
}

resource "aws_security_group" "mysg" {
  name = "mysg"
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.mysgingress]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [var.mysgingress]
  }

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = [var.mysgingress]
  }
  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = [var.mysgingress]
  }
  egress {
    from_port   = 0
    protocol    = "tcp"
    to_port     = 65535
    cidr_blocks = ["0.0.0.0/0"]

  }
}
output "mysg" {
  value = aws_security_group.mysg.id
}