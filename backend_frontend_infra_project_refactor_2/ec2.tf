resource "aws_instance" "my_ec2s" {
 count = "${length(var.ec2s)}"    # for loop to add two resource. 
    ami           = "${var.ami}"
    instance_type = "${var.instance_type}"
    tags = {
        Name  = "${element(var.ec2s, count.index)}"
    }
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = ["${aws_security_group.allow_http_only.id}"]
}