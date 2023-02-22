resource "aws_lakeformation_lf_tag" "example" {
  depends_on=[aws_lakeformation_permissions.xgov-db-admin]
  key    = "sensitivity"
  values = ["public", "private", "confidential"]
}



