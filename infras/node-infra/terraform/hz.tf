# data "aws_route_53" "dev_test_project" {
#   name         = "test.xyz"
#   private_zone = false
# }

# resource "aws_route53_record" "lb_record" {
#   zone_id = data.aws_route_53.dev_test_project.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = var.aws_lb_dns_name
#     zone_id                = var.aws_lb_zone_id
#     evaluate_target_health = true
#   }
# }
