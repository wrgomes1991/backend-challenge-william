resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}
