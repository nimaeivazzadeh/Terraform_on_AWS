resource "aws_security_group" "allow_http_only" {
    name        = "allow_http"
    description = "allow_http_inbound, allow all traffic outbound"
    
    ingress {
        description = "allow http in"
        from_port   = 80
        to_port     = 80
        protocol    = "TCP"
        cidr_blocks  = ["0.0.0.0/0"]

    }
    egress {
        description = "allow all outbound traffic "
        from_port   = 0 # 0 it defines all traffic
        to_port     = 0 
        protocol    = "-1" # refers to all traffic
        cidr_blocks  = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow_http_inbound, allow all traffic outbound"
    }
}