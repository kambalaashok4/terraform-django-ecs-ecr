

resource "aws_ecs_cluster" "aws-container-aws_ecs_cluster" {
  name = var.aws_ecs_cluster
  tags = {
    
    Name = "django-ecs-cluster"
  }
  
}

resource "aws_internet_gateway" "aws-container-internet-gateway" {
  vpc_id = aws_vpc.aws-container-vpc.id
  
  tags = {
    Name = "django-ecs-internet-gateway"
  }
}



resource "aws_route_table" "aws-container-route-table" {
  vpc_id = aws_vpc.aws-container-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-container-internet-gateway.id
  }

  tags = {
    Name = "django-ecs-route-table"
  }
}

resource "aws_vpc" "aws-container-vpc" {
  cidr_block = "10.0.0.0/16"
 enable_dns_hostnames = true
 enable_dns_support = true
 tags = {
    Name = "django-ecs-vpc"
  }
  
}

resource "aws_subnet" "aws-container-subnet1" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.aws-container-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "django-ecs-subnet1"
}
}

resource "aws_subnet" "aws-container-subnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.aws-container-vpc.id
  availability_zone = "us-east-1b"
  #map_customer_owned_ip_on_launch = true
  map_public_ip_on_launch = true
  tags = {
    Name = "django-ecs-subnet2"
  }
}


resource "aws_route_table_association" "public_route_table_1" {
    subnet_id      = aws_subnet.aws-container-subnet1.id
    route_table_id = aws_route_table.aws-container-route-table.id
}
resource "aws_route_table_association" "public_route_table_2" {
    subnet_id = aws_subnet.aws-container-subnet2.id
    route_table_id = aws_route_table.aws-container-route-table.id
}

resource "aws_security_group" "aws-container-security-group" {
  name        = "django-ecs-security-group"
  description = "Security group for Django ECS service"
  vpc_id      = aws_vpc.aws-container-vpc.id
  tags = {
    Name = "django-ecs-security-group"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "app_service" {
  name           = var.aws_ecs_service
  enable_execute_command = true
  cluster        = aws_ecs_cluster.aws-container-aws_ecs_cluster.id
  task_definition = aws_ecs_task_definition.aws-container-aws_ecs_task_definition.arn
  desired_count  = var.desired_count
  launch_type    = "FARGATE"
  deployment_controller {
    type = "ECS"
  }
  load_balancer {
    
    target_group_arn = aws_alb_target_group.django-alb-target-group.arn
    container_port = "8000"
    #container_name = aws_ecs_task_definition.aws-container-aws_ecs_task_definition.family
    container_name = var.aws_ecs_container_name
  }

  network_configuration {
    subnets         = [aws_subnet.aws-container-subnet1.id, aws_subnet.aws-container-subnet2.id]

    security_groups = [aws_security_group.aws-container-security-group.id]
    assign_public_ip = var.assign_public_ip
  }

  depends_on = [aws_ecs_task_definition.aws-container-aws_ecs_task_definition]
}


resource "aws_ecs_task_definition" "aws-container-aws_ecs_task_definition" {
  family                   = var.aws_ecs_task_definition
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  
  execution_role_arn       = var.ecs_task_role_arn
  task_role_arn       = var.ecs_task_role_arn
 
  container_definitions = jsonencode([
    {
      #name      = "django-container"
      name = var.aws_ecs_container_name
      image = "${var.aws_ecr_repository}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}


resource "aws_alb" "django-alb" {
  name            = "django-ecs-alb"
  internal        = false
  security_groups = [aws_security_group.aws-container-security-group.id]
  subnets         = [aws_subnet.aws-container-subnet1.id, aws_subnet.aws-container-subnet2.id]

  load_balancer_type = "application"

  tags = {
    Name = "django-ecs-alb"
  }
}


resource "aws_alb_target_group" "django-alb-target-group" {
  name             = "django-alb-target-group"
  port             = 8000
  protocol         = "HTTP"
  vpc_id           = aws_vpc.aws-container-vpc.id
  target_type      = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

resource "aws_alb_listener" "django-alb-listener" {
  load_balancer_arn = aws_alb.django-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.django-alb-target-group.arn
  }
}