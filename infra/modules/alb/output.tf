output "alb_tg_arn" {
  description = "ARN of the ALB target group"
  value = aws_lb_target_group.tg.arn
}

output "alb_dns_name" {
  description = "DNS name of ALB"
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  description = "Hosted Zone ID of the ALB"
  value = aws_lb.alb.zone_id
}