resource "aws_instance" "myeip" {
    ami = "ami-04d5cc9b88f9d1d39"
    instance_type = "t2.micro"
    tags = {
        Name = "myeip"
    }
    key_name = "first_instance"
}