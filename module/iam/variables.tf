variable "ecs_task_role_arn" {
    description = "ARN of the IAM role for ECS task execution"
    type = string
  
}

variable "ecs_task_role_name" { 
    type = string 
    default = "ecs-task-role"
     }

variable "ecs_task_policy" {
        type = string
        default = "ecs-task-policy" 
      
}

variable "aws_iam_role_policy_attachment" {
    type = string
    default = "ecs_task_role_attachment"    
  
}