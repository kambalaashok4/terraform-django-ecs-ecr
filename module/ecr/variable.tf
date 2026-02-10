variable "aws_ecr_repository" {
    description = "URL of the ECR repository"
    type = string  
}

variable "image_tag_mutability" {
    type = string
    default = "MUTABLE"
    description = "The image tag mutability setting for the ECR repository"
  
}
variable "encryption_configuration" {
  type = object({
    encryption_type = string
  })
  default = {
    encryption_type = "AES256"
  }
}