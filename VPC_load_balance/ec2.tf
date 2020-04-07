resource "aws_instance" "public_ec2s" {
  count                     = "${length(var.public_subnet_cidr)}"
    ami                     = "${var.ami}"
    instance_type           = "${var.instance_type}"
    availability_zone       = "${element(var.availability_zones, count.index)}"
    vpc_security_group_ids  = ["${aws_security_group.ec2_public_security_group.id}"]
    subnet_id               = "${aws_subnet.public_subnets[count.index].id}"
key_name                    = "virginia"
tags = {
    Name = "${format("public_ec2s-%d", count.index+1)}"
}
user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd.service
                systemctl enable httpd.service
                echo "Hi I am a public ec2 instance : $(hostname -f)" > /var/www/html/index.html
                EOF
  depends_on = ["aws_vpc.main_vpc","aws_subnet.public_subnets", "aws_security_group.ec2_public_security_group"]
}

resource "aws_instance" "private_ec2s" {
  count                     = "${length(var.private_subnet_cidr)}"
    ami                     = "${var.ami}"
    instance_type           = "${var.instance_type}"
    availability_zone       = "${element(var.availability_zones, count.index)}"
    vpc_security_group_ids  = ["${aws_security_group.ec2_private_security_group.id}"]
    subnet_id               = "${aws_subnet.private_subnets[count.index].id}"
key_name                    = "virginia"
tags = {
    Name = "${format("private_ec2s-%d", count.index+1)}"
}
user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "Hi I am a private ec2 instance : $(hostname -f)" > /var/www/html/index.html
              EOF
  depends_on = ["aws_vpc.main_vpc","aws_subnet.private_subnets", "aws_security_group.ec2_private_security_group"]
}
