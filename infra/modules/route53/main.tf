data "aws_route53_zone" "selected" {
  name         = "adnaan-application.com"
}


# Create an Alias A record  (since ALB doesnt have fixd ip, so i use alb endpoint)

resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "adnaan-application.com"
  type    = "A"

  alias {     
    name                   = var.alb_dns_name   
    zone_id                = var.alb_zone_id    #which hosted zone owns that dns name
    evaluate_target_health = true
  }
}

