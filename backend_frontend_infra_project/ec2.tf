resource "aws_instance" "front" {
  ami           = "ami-0fc61db8544a617ed"
  instance_type = "t2.micro"
  tags = {
      Name  = "front"
  }
  subnet_id = "subnet-0ca2dbfe3d291a35d"
  vpc_security_group_ids = ["${aws_security_group.allow_http_only.id}"]
}


resource "aws_instance" "back" {
  ami           = "ami-0fc61db8544a617ed"
  instance_type = "t2.micro"
  tags = {
      Name      = "back"
  }
  subnet_id = "subnet-0ca2dbfe3d291a35d"
  vpc_security_group_ids = ["${aws_security_group.allow_http_only.id}"]
}
