module "my_ec2" {
    source = "../modules"
    instance_type = "t2.large"
    ec2-name = "my_prod_EC2"
}