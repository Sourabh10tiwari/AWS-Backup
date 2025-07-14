output "backup_vault_name" {
  value = aws_backup_vault.default.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.backup_bucket.bucket
}

