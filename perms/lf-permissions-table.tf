resource "aws_lakeformation_permissions" "test" {
  principal                     = data.aws_iam_role.lf-admin.arn
  permissions                   = ["ALL", "ALTER", "DELETE", "DESCRIBE", "DROP", "INSERT", "SELECT"]
  permissions_with_grant_option = ["ALL", "ALTER", "DELETE", "DESCRIBE", "DROP", "INSERT", "SELECT"]

  lf_tag_policy {
    resource_type = "TABLE"
  
    expression {
      key    = aws_lakeformation_lf_tag.tags-xgov.key
      values = ["public","private","confidential"]
    }
  }

}
