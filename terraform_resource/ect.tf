resource "aws_instance" "minstance" {
    ami = "ami-04d5cc9b88f9d1d39"
    instance_type = "t2.micro"
    tags = {
        Name = "hello terraform"
    }
    key_name = "first_instance"
    user_data = <<-EOF
                    #!/bin/bash
                    yum update 
                    yum install -y httpd
                    systemctl start httpd.service
                    systemctl enable httpd.service
                    echo "Hi there, I am $(hostname -f)" > /var/www/html/index.html
                    EOF
}