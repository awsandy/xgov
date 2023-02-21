
resource "aws_glue_crawler" "xgov" {
  database_name = "xgov"
  name          = "xgov"
  # this role comes from CloudFormation
  role          = data.aws_iam_role.LF-GlueServiceRole.arn

  s3_target {
    path = "s3://${aws_s3_bucket.xgov-data.bucket}/raw-data"
  }
}









