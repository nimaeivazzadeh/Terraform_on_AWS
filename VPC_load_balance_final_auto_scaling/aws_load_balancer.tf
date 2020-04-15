# This is an application-based load balancer allows traffic goes to public subnets in the infrastructure. 
resource "aws_alb" "web_application_load_balancer" {
    load_balancer_type = "application"
    name               = "Production-webapp-load-balancer"
    internal           = false
    security_groups    = ["${aws_security_group.elb_security_group.id}"]
tags = {
    Name = "web_application_load_balancer"
}
    subnets    = "${aws_subnet.public_subnets.*.id}"
    depends_on = ["aws_subnet.public_subnets", "aws_security_group.elb_security_group"]
}

resource "aws_lb_target_group" "alb_front_http" {
  name     = "alb-front-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main_vpc.id}"
  health_check {
            path     = "/"
            port     = "80"
            protocol = "HTTP"
            healthy_threshold   = 5
            unhealthy_threshold = 2
            interval = 5
            timeout  = 4
            matcher  = "200"
  }
tags = {
    Name = "alb_front_http"
}
  depends_on = ["aws_vpc.main_vpc"]
}

resource "aws_lb_target_group_attachment" "target_group_alb" {
    count = "${length(var.public_subnet_cidr)}"
        target_group_arn = "${aws_lb_target_group.alb_front_http.arn}"
        target_id        = "${element(aws_instance.public_ec2s.*.id, count.index)}"
        port             = 80
}

resource "aws_alb_listener" "front_end" {
    load_balancer_arn = "${aws_alb.web_application_load_balancer.arn}"
    port     = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = "${aws_lb_target_group.alb_front_http.arn}"

    }
   depends_on = ["aws_alb.web_application_load_balancer", "aws_lb_target_group.alb_front_http"]
}
