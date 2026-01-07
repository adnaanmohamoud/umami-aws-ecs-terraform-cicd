# Create ECS cluster

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# Create Task Definition

resource "aws_ecs_task_definition" "service" {
  family = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  
  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "umami-task"
      image     = "427587740275.dkr.ecr.eu-west-2.amazonaws.com/umami22@sha256:012d795e38afe6382eeb79c4f9fc7e1fd11f3c3a506aae808a71ec05ace36abd"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort = 3000
          protocol      = "tcp"
        }
      ]


      # I am going to change this to using secret manager, right now im just hardcoding to see if everything works

      environment = [
        {
          name = "DATABASE_URL"
          value = "postgresql://dbadmin:Ronaldo123@umami-rds.c9eakmui0hkf.eu-west-2.rds.amazonaws.com:5432/mydb?sslmode=no-verify" #postgresql://admin:Ronaldo123@${var.db_host}:${var.db_port}/${var.db_name}
        },
        {
          name = "HOSTNAME"
          value = "0.0.0.0"
        },
        {
          name = "APP_SECRET"
          value = "replace-me-with-a-random-string"
        },
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = "eu-west-2"
          awslogs-stream-prefix = var.log_stream_prefix
        }
      }
    },
  ])

}

# Create the Service to manage these tasks

resource "aws_ecs_service" "umami" {
  name            = "umami-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.service.arn 
  launch_type = "FARGATE"
  desired_count   = 2
  
  network_configuration {
    subnets = [ var.private_subnet_a, var.private_subnet_b ]
    security_groups = [var.task_sg]
  }

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "umami-task"
    container_port   = 3000
  }
}