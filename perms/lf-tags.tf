resource "aws_lakeformation_lf_tag" "tags-xgov" {
  key    = "sensitivity"
  values = ["public", "private", "confidential"]
}

resource "aws_lakeformation_lf_tag" "tags-share" {
  key    = "share"
  values = ["team1","team2","team3","central"]
}

