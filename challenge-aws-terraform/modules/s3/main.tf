resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "tfstate"
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.this.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
