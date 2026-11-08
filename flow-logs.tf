resource "aws_s3_bucket" "flow_logs" {
  count = var.create_vpc && var.vpc_flow_logs_bucket_arn == "" ? 1 : 0
  bucket = "vpc-flow-logs"
  tags = merge(
    var.tags,
    {
      Name = "$vpc-flow-logs"
    },
  )
}

# Enable server-side encryption (SSE-S3 or KMS)
resource "aws_s3_bucket_server_side_encryption_configuration" "flow_logs" {
  count = var.create_vpc && var.vpc_flow_logs_bucket_arn == "" ? 1 : 0
  bucket = aws_s3_bucket.flow_logs[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "flow_logs" {
  count = var.create_vpc && var.vpc_flow_logs_bucket_arn == "" ? 1 : 0
  bucket = aws_s3_bucket.flow_logs[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "flow_logs" {
  count = var.create_vpc && var.vpc_flow_logs_bucket_arn == "" ? 1 : 0
  bucket = aws_s3_bucket.flow_logs[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "flow_logs" {
  count = var.create_vpc && var.vpc_flow_logs_bucket_arn == "" ? 1 : 0
  bucket = aws_s3_bucket.flow_logs[0].id

  rule {
    id     = "archive-logs"
    status = "Enabled"

    filter {
      prefix = ""
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}
# immutability
resource "aws_s3_bucket_object_lock_configuration" "flow_logs" {
  count = var.create_vpc && var.vpc_flow_logs_bucket_arn == "" ? 1 : 0
  bucket = aws_s3_bucket.flow_logs[0].id
  rule {
    default_retention {
    mode  = "GOVERNANCE"
    days  = 365
    }
  }
}

resource "vpc_flow_logs" "this" {
  count = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  traffic_type = "ALL"
  log_destination_type = "s3"
  log_destination = var.vpc_flow_logs_bucket_arn != "" ? var.vpc_flow_logs_bucket_arn : aws_s3_bucket.flow_logs[0].arn
  log_format = local.vpc_flow_log_format
}