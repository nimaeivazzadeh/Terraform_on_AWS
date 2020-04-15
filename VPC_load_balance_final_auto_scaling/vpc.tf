resource "aws_vpc" "main_vpc" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = true

    tags = {
        Name = "VPC_TF"
    }
    
}
resource "aws_security_group" "ec2_public_security_group" {
    name        = "ec2_public_security_group"
    description = "Internet reaching access to public ec2s"
    vpc_id      = "${aws_vpc.main_vpc.id}" # aligned this security group to the above aws_vpc

    ingress    {
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress    {
        from_port   = 80
        to_port     = 80
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    tags = {
        Name = "ec2_public_security_group"
    }

    depends_on = ["aws_vpc.main_vpc"]
}

resource "aws_security_group" "ec2_private_security_group" {
    name        = "ec2_private_security_group"
    description = "Only allow public Security Group resources to access to private instances."
    vpc_id      = "${aws_vpc.main_vpc.id}" # aligned this security group to the above aws_vpc
    
    ingress    {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.ec2_public_security_group.id}"]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    tags = {
        Name = "ec2_private_security_group"
    }

    depends_on = ["aws_vpc.main_vpc", "aws_security_group.ec2_public_security_group"]
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = "${aws_vpc.main_vpc.id}"  # to assign an internet gateway to the main_vpc.

    tags = {
        Name = "internet_gateway"
    }

    depends_on = ["aws_vpc.main_vpc"]

}

resource "aws_eip" "elastic_ip" {
    vpc  = true

    tags = {
        Name = "elastic_ip"
    }
     
}

resource "aws_nat_gateway" "NAT_Gateway" {
    allocation_id = "${aws_eip.elastic_ip.id}"
    subnet_id     = "${aws_subnet.public_subnets[0].id}" # 

    tags = {
        Name = "NAT_Gateway"
    }
    depends_on = ["aws_eip.elastic_ip","aws_subnet.public_subnets"]
}

resource "aws_security_group" "elb_security_group" {
    name        = "elb_security_group"
    description = "elb security group"
    vpc_id      = "${aws_vpc.main_vpc.id}"

    ingress{
        from_port   = 80
        to_port     = 80
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow web traffic to load balancer"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "elb_security_group"
    }
  }
