variable "ami" {
    default = "ami-0fc61db8544a617ed"
    
}

variable "instance_type" {
    default = "t2.micro"
}

variable "availability_zone" {
    type = "list"
    default = ["us-east-1a",
               "us-east-1b",
               "us-east-1c"  
              ]
}
