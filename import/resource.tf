resource "aws_instance" "my_import" {
  ami  = "ami-04d5cc9b88f9d1d39"
  instance_type = "t2.nano"
  tags  = {
      Name = "my_import"
  }
  key_name = "first_instance"
}

resource "aws_instance" "my_import_created_by_Paul_manually" {
  ami = "ami-04d5cc9b88f9d1d39"
  instance_type = "t2.nano"
  tags = {
      Name = "Imported_successfully"
  }
}
