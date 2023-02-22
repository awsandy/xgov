resource "aws_lakeformation_lf_tag" "example" {
  key    = "sensitivity"
  values = ["public", "private", "confidential"]
}



