
resource "aws_glue_crawler" "xgov" {
  database_name = "xgov"
  name          = "xgov"
  # this role comes from CloudFormation
  role          = data.aws_iam_role.LF-GlueServiceRole.arn

  s3_target {
    path = "s3://${aws_s3_bucket.xgov-data.bucket}/raw-data"
  }
}

resource "aws_glue_crawler" "xgov2" {
  database_name = "xgov"
  name          = "xgov2"
  # this role comes from CloudFormation
  role          = data.aws_iam_role.lf-admin.arn

  s3_target {
    path = "s3://${aws_s3_bucket.xgov-data.bucket}/raw-data"
  }
}









