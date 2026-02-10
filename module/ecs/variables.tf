variable "aws_ecs_cluster" {
    description = "Name of the ECS cluster"
    type = string
    default = "django-ecs-cluster"
  
}

variable "aws_ecs_service" {
    description = "Name of the ECS service"
    type = string
    default = "django-ecs-service"
  
}

variable "aws_ecs_task_definition" {
    description = "Name of the ECS task definition"
    type = string
    default = "django-ecs-task"
  
}

variable "aws_ecr_repository" {
    description = "URL of the ECR repository"
    type = string
  
}

variable "aws_ecs_execution_role_arn" {
  type        = string
  description = "ARN of the ECS task execution role"
  default     = ""
}

variable "ecs_task_role_arn" {
  type        = string
  description = "ARN of the ECS task execution role"
}

variable "desired_count" {
  description = "Number of desired task replicas for the task set"
  type        = number
  default     = 1
}


variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
  default     = []
  
}
variable "security_group_ids" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
  default     = []
  
}
variable "assign_public_ip" {
  description = "Whether to assign a public IP address to the ECS tasks"
  type        = bool
  default     = true
}

variable "aws_route_table_association" {
  description = "Associations between subnets and route tables"
  type        = map(string)
  default     = {}
  
}

variable "aws_ecs_container_name" {
  description = "Name of the container in the ECS task definition"
  type        = string
  default     = "django-container"
  
}