resource "aws_iam_role" "ecs_task_role" {
  #name = "${var.aws_ecs_execution_role_arn}-role"
  #name = replace(var.aws_ecs_execution_role_arn, "arn:aws:iam::", "") # Extract the role name from the ARN
  #name ="${var.ecs_task_role_arn}"
  name = var.ecs_task_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      } 
    ]
  })
}

resource "aws_iam_policy" "ecs_task_policy" {
  name        = var.ecs_task_policy
  description = "Policy for ECS task execution role"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:*",
          "ecs:*"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "ecs_task_role_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
