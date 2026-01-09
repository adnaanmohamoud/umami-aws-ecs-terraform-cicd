data "aws_route53_zone" "selected" {
  name         = "adnaan-application.com"
}

resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "adnaan-application.com"
  type    = "A"

  alias {     
    name                   = var.alb_dns_name   
    zone_id                = var.alb_zone_id  
    evaluate_target_health = true
  }
}

