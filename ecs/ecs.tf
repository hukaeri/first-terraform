resource "aws_ecs_cluster" "main" {
  name = "learn-ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family             = "cb-app-task"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  #  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  container_definitions    = <<DEFINITION
  [
    {
      "name": "learn-ecs-pub-api-task",
      "image": "160071257600.dkr.ecr.eu-west-1.amazonaws.com/ecs-learn-repository:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 5000,
          "hostPort": 5000
        }
      ]
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "main" {
  name            = "learn-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "learn-ecs-pub-api-task"
    container_port   = 5000
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}