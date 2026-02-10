module "aws_ecr_repository" {
    source = "./module/ecr"
    aws_ecr_repository = "ecr-django"
    image_tag_mutability = "MUTABLE"
    encryption_configuration = {
      encryption_type = "AES256"
    }
  
}

module "aws_ecs_cluster" {
    source = "./module/ecs"
    aws_ecs_cluster = "aws-container-aws_ecs_cluster"
    aws_ecs_task_definition = "aws-container-aws_ecs_task_definition"
    aws_ecr_repository = module.aws_ecr_repository.aws_ecr_repository
    #aws_ecs_execution_role_arn = module.aws_iam_role.ecs_task_role_arn
    ecs_task_role_arn = module.aws_iam_role.ecs_task_role_arn
    
    #ecs_task_role_arn = provider::aws::trim_iam_role_path(module.aws_iam_role.ecs_task_role_arn)
    aws_ecs_service = "aws-container-aws_ecs_service"
    desired_count = 1

    #subnet_ids = [module.aws_vpc.aws-container-subnet1.id, module.aws_vpc.aws-container-subnet2.id]
    #security_group_ids = [module.aws_security_group.aws-container-security-group.id]
    assign_public_ip = true
}



module "aws_iam_role" {
    source = "./module/iam"
    ecs_task_role_arn = "ecs-task-role"
    ecs_task_policy = "ecs-task-policy"
    ecs_task_role_name = "ecs-task-role"
    aws_iam_role_policy_attachment = "ecs_task_role_attachment"
    
}
