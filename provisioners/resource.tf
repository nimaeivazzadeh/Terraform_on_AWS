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
resource "null_resource" "ssh_connection" {
    connection {
      host = "${aws_instance.my_provision.public_ip}"
      type = "ssh"
      port = 22
      user = "ec2-user"
      private_key = "${file("/home/nima/Downloads/first_instance.pem")}"
      timeout = "1m"
      agent = false
    }
provisioner "file" {
      source = "index.html"
      destination = "/home/ec2-user/index.html" # cp index.html ec2-user@eip /var/index.html
}
provisioner "remote-exec" {
  inline = [
    "sudo yum update -y",
    "sudo yum install -y httpd",
    "sudo yum systemctl start httpd.service",
    "sudo yum systemctl enable httpd.service",
    "sudo cp /home/ec2-user/index.html /var/www/html/index.html",
  ]
 }
}
resource "aws_eip" "provisioner_eip" {
  instance = "${aws_instance.my_provision.id}"
}

output "my_provisioner" {
  value = "${aws_eip.provisioner_eip.public_ip}"
}
