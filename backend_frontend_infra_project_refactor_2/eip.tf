resource "aws_eip" "elastic_ip" {
  instance = "${aws_instance.my_ec2s[0].id}"
}