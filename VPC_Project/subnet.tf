# Two public and private subnets in the VPC.
resource "aws_subnet" "public_subnet_A" {
    vpc_id      = "${aws_vpc.main_vpc.id}"
    cidr_block = "10.0.0.0/24"
    # availability_zone = "us-east-1"
    map_public_ip_on_launch = true # to get a public IP to this subnet. 
    tags = {
        Name ="public_subnet_A"
    }

    depends_on = ["aws_vpc.main_vpc"] # This shows the aws_subnet resources has dependent on the main aws_vpc we have in this structure.
}

resource "aws_subnet" "private_subnet_A" {
    vpc_id = "${aws_vpc.main_vpc.id}"
    cidr_block = "10.0.16.0/20"

    tags = {
        Name = "private_subnet_A"
    }
    depends_on = ["aws_vpc.main_vpc"]
}
