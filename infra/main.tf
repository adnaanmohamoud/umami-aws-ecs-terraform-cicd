module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"

  vpc_id = module.vpc.vpc_id
  
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  alb_sg = module.sg.alb_sg
  public_subnet_a = module.vpc.public_subnet_a
  public_subnet_b = module.vpc.public_subnet_b
  acm_certificate_arn = module.acm.certificate_arn

  health_check_path = "/"
}

module "secret" {
  source = "./modules/secret-manager"
}

module "rds" {
  source = "./modules/rds"
  rds_subnet_id = [module.vpc.private_subnet_a, module.vpc.private_subnet_b]
  rds_sg = [module.sg.rds_sg]

  db_secret_arn = module.secret.secret_arn
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source = "./modules/ecs"

  db_host = module.rds.hostname
  db_port = module.rds.port
  db_name = module.rds.db_name

  task_role_arn      = module.iam.ecs_task_role_arn
  execution_role_arn = module.iam.ecs_execution_role_arn

  alb_tg_arn = module.alb.alb_tg_arn
  task_sg = module.sg.task_sg

  private_subnet_a = module.vpc.private_subnet_a
  private_subnet_b = module.vpc.private_subnet_b

  log_group_name    = module.cloudwatch.ecs_log_group_name    #need to go through this
  log_stream_prefix = "ecs"       #need to go through this

}

module "cloudwatch" {
  source              = "./modules/cloudwatch"
  ecs_log_group_name  = "/ecs/umami"
  ecs_cpu_threshold   = 80
  ecs_memory_threshold= 80
}

module "route53" {
  source = "./modules/route53"
  
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "acm" {
  source              = "./modules/acm"

  domain_name = "adnaan-application.com"
  zone_id     = module.route53.zone_id
}

