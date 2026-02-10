output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "aws_iam_role" {
    value = aws_iam_role.ecs_task_role
    description = "The ARN of the IAM role for ECS task execution"
  
}

output "iam_policy_arn" {
  value = aws_iam_policy.ecs_task_policy.arn
  description = "The ARN of the IAM policy for ECS task execution"
  
}

output "aws_iam_policy" {
  value = aws_iam_policy.ecs_task_policy
  description = "The ARN of the IAM policy for ECS task execution"
  
}