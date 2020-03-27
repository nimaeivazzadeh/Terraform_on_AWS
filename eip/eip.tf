resource "aws_eip" "myeip" {
  instance = "${aws_instance.my_eip_instance.id}"
  vpc      = true
}