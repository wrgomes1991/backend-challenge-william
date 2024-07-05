resource "aws_security_group" "this" {
  name        = var.name
  description = "Security group with port 443 open"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}

output "security_group_id" {
  value = aws_security_group.this.id
}
