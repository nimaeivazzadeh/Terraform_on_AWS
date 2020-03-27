resource "aws_eip" "myeip" {
  instance = "${aws_instance.my_eip_instance.id}"
  vpc      = true
}

output "my_eip_address" {  # to output the result in console
  value = "${aws_eip.myeip}" 
}
