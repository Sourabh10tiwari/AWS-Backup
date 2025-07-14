resource "aws_s3_bucket" "versioned_bucket" {
  bucket = "versioned-bucket-34785"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    Name = "versioned-bucket"
  }
}
