
resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0" # all the traffic should go to internet gateway.
        gateway_id = "${aws_internet_gateway.internet_gateway.id}"  # assigned to the internet gateway. 
    }

    tags = {
        Name = "public_route_table"
    }
    depends_on = ["aws_vpc.main_vpc","aws_internet_gateway.internet_gateway"]
}


resource "aws_route_table_association" "public_route_table_association" {
    count = "${length(var.public_subnet_cidr)}"
    subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.public_route_table.id}"
    depends_on = ["aws_route_table.public_route_table", "aws_subnet.public_subnets"]
  
}

# To assign the route table to private subnet. 
resource "aws_route_table" "private_route_table" { 
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0" # all the traffic should go to internet gateway.
        gateway_id = "${aws_nat_gateway.NAT_Gateway.id}"  # assigned to the internet gateway. 
    }

    tags = {
        Name = "private_route_table"
    }
    depends_on = ["aws_vpc.main_vpc","aws_nat_gateway.NAT_Gateway"]
}

resource "aws_route_table_association" "private_route_table_association" {
    count = "${length(var.private_subnet_cidr)}"
    subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.private_route_table.id}"
    depends_on = ["aws_route_table.private_route_table", "aws_subnet.private_subnets"]
  
}