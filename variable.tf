variable "aws_alb_name" {
    description = "Name of the Application Load Balancer"
    default = "django-alb"
  
}


variable "aws_alb_target_group_name" {
   
    description = "Name of the Application Load Balancer Target Group"
    default = "django-alb-target-group"
  
}