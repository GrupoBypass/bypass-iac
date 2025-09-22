resource "aws_s3_bucket" "this" {
  count = var.bucket_count

  bucket = var.use_custom_names ? var.bucket_names[count.index] : "${var.bucket_prefix}-${count.index + 1}-${random_id.suffix.hex}"

  tags = merge(
    {
      Name = "Public Bucket ${count.index + 1}"
    },
    var.tags
  )
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.bucket_count

  bucket = aws_s3_bucket.this[count.index].id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "this" {
  count = var.bucket_count

  bucket = aws_s3_bucket.this[count.index].id
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_policy" "this" {
  count = var.bucket_count

  bucket = aws_s3_bucket.this[count.index].id
  policy = templatefile("${path.module}/templates/bucket-policy.json.tpl", {
    bucket_arn = aws_s3_bucket.this[count.index].arn
  })
}

# Optional: Enable versioning
resource "aws_s3_bucket_versioning" "this" {
  count = var.enable_versioning ? var.bucket_count : 0

  bucket = aws_s3_bucket.this[count.index].id
  versioning_configuration {
    status = "Enabled"
  }
}

# Optional: Website configuration
resource "aws_s3_bucket_website_configuration" "this" {
  count = var.enable_website ? var.bucket_count : 0

  bucket = aws_s3_bucket.this[count.index].id

  index_document {
    suffix = var.website_index_document
  }

  error_document {
    key = var.website_error_document
  }
}
