resource "aws_lakeformation_permissions" "db-xgov" {
  principal   = data.aws_iam_role.lf-admin.arn
  permissions = ["ALL"]

  lf_tag_policy {
    resource_type = "DATABASE"

    expression {
      key    = aws_lakeformation_lf_tag.tags-xgov.key
      values = ["public","private","confidential"]
    }
  }
}

