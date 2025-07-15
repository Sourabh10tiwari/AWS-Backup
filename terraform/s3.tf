resource "aws_s3_bucket" "versioned_bucket" {
  bucket = "versioned-bucket-34785"
  force_destroy = true

  tags = {
    Name = "versioned-bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.versioned_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
