resource "aws_lakeformation_resource_lf_tags" "example" {
  database {
    name = "xgov"
  }

  lf_tag {
    key   = "sensitivity"
    value = "public"
  }

  lf_tag {
    key   = "sensitivity"
    value = "private"
  }

  lf_tag {
    key   = "sensitivity"
    value = "confidential"
  }
}