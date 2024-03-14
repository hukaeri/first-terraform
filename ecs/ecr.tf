resource "aws_ecr_repository" "ecr_repo" {
  name                 = "ecs-learn-repository"
  image_tag_mutability = "IMMUTABLE"
}
