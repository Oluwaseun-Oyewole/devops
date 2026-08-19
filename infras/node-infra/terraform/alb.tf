##############################
# Application Load Balancer
##############################

resource "aws_lb" "jenkins" {
  name               = "${var.project_name}-jenkins-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id, aws_security_group.jenkins.id]

  # ALB must span at least 2 AZs - reuse the public subnets already created
  subnets = [for s in aws_subnet.public : s.id]

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-jenkins-alb"
  }
}

############################## 
# Listener - accepts traffic on port 80 and forwards to the target group
##############################
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.jenkins.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }
}
