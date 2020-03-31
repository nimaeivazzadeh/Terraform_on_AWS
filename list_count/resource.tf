
# for loop to create multiple instances in different regins on AWS. 
resource "aws_instance" "myec2" {
    count = "${length(var.availability_zone)}"
        ami = "${var.ami}"
        instance_type = "${var.instance_type}"
        availability_zone = "${element(var.availability_zone, count.index)}"
        tags = {
            Name = "myec2_${element(var.availability_zone, count.index)}"
        }
}

output "myec2" {
    value = "${aws_instance.myec2}"
}
