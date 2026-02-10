output "aws_ecr_repository" {
    value = aws_ecr_repository.ecr-django.repository_url
  description = "URL of the ECR repository"
}