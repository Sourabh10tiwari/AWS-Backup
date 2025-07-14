resource "aws_s3_bucket" "backup_bucket" {
  bucket = "Backup_Of_Instances_34785"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    Name = "Backup_Of_Instances"
  }
}
