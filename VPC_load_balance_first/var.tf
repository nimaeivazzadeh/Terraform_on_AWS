variable "ami" {
   default = "ami-0fc61db8544a617ed"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "availability_zones" {
    type = "list"
    default = ["us-east-1a", 
               "us-east-1b"
              ]
}

variable "public_subnet_cidr" {
    type = "list"
    default = ["10.0.0.0/24",
               "10.0.1.0/24"
              ]
}

variable "private_subnet_cidr" {
  type  = "list"
  default = ["10.0.2.0/24",
             "10.0.3.0/24"
            ]
}



