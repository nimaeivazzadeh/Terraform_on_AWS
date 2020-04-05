resource "aws_eip" "elastic_ip" {
  instance = "${aws_instance.front.id}"
}


