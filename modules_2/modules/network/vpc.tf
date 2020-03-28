resource "aws_vpc" "my_vpc" {
    cidr_block = "${var.cidr_vpc}"
    instance_tenancy = "${var.cidr_instance_tenancy}"
    tags = {
        Name = "my_vpc"
    }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.cidr_subnet}"
  tags = {
      Name = "subnet_module_2"
  }
  availability_zone = "${var.availability_zone}"
  depends_on = ["aws_vpc.my_vpc"]
}

output "vpc_id" {
  value = "${aws_vpc.my_vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.my_subnet.id}"
}
