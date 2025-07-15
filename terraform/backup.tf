resource "aws_backup_vault" "default" {
  name = "ec2-backup-vault"
}

resource "aws_backup_plan" "daily" {
  name = "daily-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.default.name
    schedule          = "cron(0 5 * * ? *)"
    lifecycle {
      delete_after = 30
    }
  }
}

resource "aws_iam_role" "backup_role" {
  name = "backup-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "backup.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_selection" "tag_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "tag-based-selection"
  plan_id      = aws_backup_plan.daily.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "Daily"
  }
}
