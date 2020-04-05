resource "aws_instance" "front" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  tags = {
      Name  = "front"
  }
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http_only.id}"]
}


resource "aws_instance" "back" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  tags = {
      Name      = "back"
  }
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http_only.id}"]
}
