resource "aws_ecr_repository" "ecr-django" {
    name = var.aws_ecr_repository
    image_tag_mutability = var.image_tag_mutability
    encryption_configuration {
        encryption_type = var.encryption_configuration.encryption_type
      
    }
}

