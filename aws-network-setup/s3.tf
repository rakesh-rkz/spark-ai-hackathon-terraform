resource "aws_s3_bucket" "my_bucket" {
  bucket = "log-a-rythm-bucket"  # Must be globally unique

  tags = {
    Name        = "log-a-rythm-bucket"
    Environment = "prod"
  }
}


resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
