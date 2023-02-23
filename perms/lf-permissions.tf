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

resource "aws_lakeformation_permissions" "test" {
  principal                     = data.aws_iam_role.lf-admin.arn
  permissions                   = ["ALL", "ALTER", "DELETE", "DESCRIBE", "DROP", "INSERT", "SELECT"]
  permissions_with_grant_option = ["ALL", "ALTER", "DELETE", "DESCRIBE", "DROP", "INSERT", "SELECT"]
  table {
    database_name = "xgov"
    name      = "customers"
  }
  lf_tag_policy {
    resource_type = "TABLE"

    expression {
      key    = aws_lakeformation_lf_tag.tags-xgov.key
      values = ["public","private","confidential"]
    }
  }

}