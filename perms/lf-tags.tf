resource "aws_lakeformation_lf_tag" "tags-xgov" {
  key    = "sensitivity"
  values = ["public", "private", "confidential"]
}



