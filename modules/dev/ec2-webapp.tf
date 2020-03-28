module "my_ec2" {
    source = "../modules"
    instance_type = "t2.micro"
    ec2-name = "my_dev_ec2"
}