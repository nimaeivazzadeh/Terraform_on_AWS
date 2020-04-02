resource "aws_instance" "public_ec2" {
  ami = "ami-04d5cc9b88f9d1d39"
  instance_type = "t2.micro"
  vpc_security_group_ids  = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = "${aws_subnet.public_subnet_A.id}"
  key_name = "first_instance"
  tags = {
      Name = "public_enc2"
  }
  depends_on = ["aws_vpc.main_vpc","aws_security_group.allow_ssh","aws_subnet.public_subnet_A"]
}


resource "aws_instance" "private_ec2" {
  ami = "ami-04d5cc9b88f9d1d39"
  instance_type = "t2.micro"
  vpc_security_group_ids  = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = "${aws_subnet.private_subnet_A.id}"
  key_name = "first_instance"
  tags = {
      Name = "private_enc2"
  }
  depends_on = ["aws_vpc.main_vpc","aws_security_group.allow_ssh","aws_subnet.private_subnet_A"]
}
