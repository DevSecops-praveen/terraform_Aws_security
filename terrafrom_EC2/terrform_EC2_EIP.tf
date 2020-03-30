#Creating ec2 inatance and EIP then associating EIP to Ec2-instance

provider "aws" {
  region     = "ap-south-1"
  access_key = "XXXX"
  secret_key = "XXXX"
}

resource "aws_instance" "myfirstec2" {
  ami           = "ami-0fa6cd5aefbf02afe"
  instance_type = "t2.micro"
}

resource "aws_eip" "myeip" {
  vpc = true
}
resource "aws_eip_association" "eip_association" {
  instance_id   = "${aws_instance.myfirstec2.id}"
  allocation_id = "${aws_eip.myeip.id}"
}
