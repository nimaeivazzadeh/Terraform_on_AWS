resource "aws_vpc" "main_vpc" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = true

    tags = {
        Name = "VPC_TF"
    }
    
}
resource "aws_security_group" "allow_ssh" {
    name        = "allow_ssh"
    description = "allow ssh inbound traffic / allow all outbound traffic"
    vpc_id      = "${aws_vpc.main_vpc.id}" # aligned this security group to the above aws_vpc
    ingress    {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    tags = {
        Name = "aws_security_group.allow_ssh"
    }

    depends_on = ["aws_vpc.main_vpc"]
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
        Name = "elastip_ip"
    }
     
}