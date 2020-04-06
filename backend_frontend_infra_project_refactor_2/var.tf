variable "ami" {
    default = "ami-0fc61db8544a617ed"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet_id" {
    default = "subnet-0ca2dbfe3d291a35d"
}

variable "ec2s" {
    type = "list"
    default = ["front-end", "back-end"]
}