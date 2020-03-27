resource "aws_instance" "my_provision" {
  ami = "ami-04d5cc9b88f9d1d39"
  instance_type = "t2.micro"
  tags = {
      Name = "my_provision"
  }
  key_name = "first_instance"
  provisioner "local-exec" {
    command = "echo ${aws_instance.my_provision.private_ip} >> private_ips.txt"
 }
}

output "my_provisioner" {
  value = "aws_instance.my_provision"
}
