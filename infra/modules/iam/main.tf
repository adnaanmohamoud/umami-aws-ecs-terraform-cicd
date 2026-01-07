# The IAM module is used to define who can do what in AWS, so in this case i am going to define iam roles


# Create a trust policy for the roles that i am going to create after
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]      # means temporarily become this identity

    principals {
      type        = "Service"       
      identifiers = ["ecs-tasks.amazonaws.com"]    #this means only the ecs service tasks is allowed to assume the roles with this trust policy
    }
  }
}    


#I created a trust policy where ECS can become a role. I then created 2 roles which ECS can assume 2 of these roles, but what differentiated these 2 roles is that I attached different permission policies to each


# Create 2 roles that they can trust/ be assumed by - in this case i made 2 roles that are trusted/assumed by ECS tasks

# Task Role
resource "aws_iam_role" "ecs_task_role" {
  name               = var.ecs_task_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

# Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = var.ecs_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}


# Although both roles uses the same policy so ecs can assume both, below we are going to differentiate both roles by attaching different policies


# Attach permission policy to execution role
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" 
}


# Attach permission policy to task role- let task/application talk to rds
