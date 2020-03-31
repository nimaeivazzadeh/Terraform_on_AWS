resource "aws_eip" "myeip_in_us_east_1" {
  vpc = true
}

resource "aws_eip" "myeip_in_eu_west_1" {
#   provider = "aws.Irland"  
  vpc = true
}

