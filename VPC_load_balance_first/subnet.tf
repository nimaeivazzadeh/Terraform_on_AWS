# Two public and private subnets in the VPC.
resource "aws_subnet" "public_subnets" {
    count                       = "${length(var.public_subnet_cidr)}"
        vpc_id                  = "${aws_vpc.main_vpc.id}"
        cidr_block              = "${element(var.public_subnet_cidr, count.index)}"
        availability_zone       = "${element(var.availability_zones, count.index)}"
        map_public_ip_on_launch = true # to get a public IP to this subnet. 
        
    tags = {
        Name ="public_subnet_${element(var.availability_zones, count.index)}"
    }

    depends_on = ["aws_vpc.main_vpc"] # This shows the aws_subnet resources has dependent on the main aws_vpc we have in this structure.
}

resource "aws_subnet" "private_subnets" {
    count                 = "${length(var.private_subnet_cidr)}"
        vpc_id            = "${aws_vpc.main_vpc.id}"
        cidr_block        = "${element(var.private_subnet_cidr, count.index)}"
        availability_zone = "${element(var.availability_zones, count.index)}"
    tags = {
        Name = "private_subnet_${element(var.availability_zones, count.index)}"
    }
    depends_on = ["aws_vpc.main_vpc"]
}
