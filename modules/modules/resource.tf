resource "aws_instance" "my_module" {
  ami = "${var.ami}"
  instance_type ="${var.instance_type}"
  security_groups = ["default"]
  tags = {
      Name = "${var.ec2-name}"
  }
  availability_zone = "${var.availability_zone}"
}
