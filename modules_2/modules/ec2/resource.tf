resource "aws_instance" "my_module" {
  ami = "${var.ami}"
  instance_type ="${var.instance_type}"
  # security_groups = ["default"]
  subnet_id = "${var.subnet_id}"
  tags = {
      Name = "${var.ec2-name}"
  }
  availability_zone = "${var.availability_zone}"
}
