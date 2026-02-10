output "aws_ecr_repository" {
    value = module.aws_ecr_repository.aws_ecr_repository
    description = "The URL of the ECR repository for the Django application"
}

output "aws_iam_role" {
    value = module.aws_iam_role.aws_iam_role
    description = "The ARN of the IAM role for ECS task execution"
  
}

output "ecs_task_role_arn" {
  value = module.aws_iam_role.ecs_task_role_arn
  description = "The ARN of the IAM role for ECS task execution"    
}