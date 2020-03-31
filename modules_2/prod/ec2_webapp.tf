module "my_vpc" {
    source = "../modules/network"
    cidr_vpc = "10.0.0.0/16"
    cidr_instance_tenancy = "default"
    vpc_id = "${module.my_vpc.vpc_id}"
    cidr_subnet = "10.0.1.0/24"
}
module "my_ec2" {
    source = "../modules/ec2"
    instance_type = "t2.large"
    ec2-name = "my_prod_ec2"
    subnet_id = "${module.my_vpc.subnet_id}"
}