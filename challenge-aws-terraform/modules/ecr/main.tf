resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  tags = {
    Name = var.name
  }
}

output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}