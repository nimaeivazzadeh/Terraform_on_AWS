resource "aws_launch_configuration" "worker" {
  name_prefix          = "Autoscaled-Terraform-"

  image_id             = "${var.ami}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${aws_security_group.elb_security_group.id}"]

  associate_public_ip_address = true
  key_name  = "virginia"
  user_data = <<-EOF
                    #!/bin/bash
                    yum update -y
                    yum install -y httpd
                    systemctl start httpd.service
                    systemctl enable httpd.service
                    echo "Hi I am a public ec2 instance lunched from Auto Scaling: $(hostname -f)" > /var/www/html/index.html
                    EOF
  lifecycle {
      create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "worker" {
  name                      = "my_auto_scaling_group_terraform_${aws_launch_configuration.worker.name}"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "ELB"
  desired_capacity          = 1
  launch_configuration      = "${aws_launch_configuration.worker.name}"
  vpc_zone_identifier       = "${aws_subnet.public_subnets.*.id}"
  target_group_arns         = ["${aws_alb_target_group.alb_front_http.arn}"]
  default_cooldown          = 30
  

  lifecycle {
    create_before_destroy   = true
    
  }
}