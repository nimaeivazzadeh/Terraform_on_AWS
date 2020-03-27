resource "aws_instance" "my_eip_instance" {
    ami = "ami-04d5cc9b88f9d1d39"
    instance_type = "t2.micro"
    tags = {
        Name = "myeip"
    }
    key_name = "first_instance"
}
