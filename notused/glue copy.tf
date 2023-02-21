resource "aws_glue_catalog_database" "xgov" {
  name = "xgov"
}


resource "aws_glue_crawler" "xgov" {
  database_name = aws_glue_catalog_database.xgov.name
  name          = "xgov"
  # this role comes from CloudFormation
  role          = data.aws_iam_role.LF-GlueServiceRole.arn

  s3_target {
    path = "s3://${data.aws_s3_bucket.xgov-data.bucket}/raw-data"
  }
}

# needed ? (not used above)
resource "aws_iam_role" "glue" {
  name               = "AWSGlueServiceRoleDefault"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["glue.amazonaws.com", "lakeformation.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.glue.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}



resource "aws_iam_role_policy" "glue_service_s3" {
  name   = "glue_service_s3"
  role   = aws_iam_role.glue.id
  policy = aws_iam_role_policy.my_s3_policy.policy
}

resource "aws_iam_role_policy" "my_s3_policy" {
  name   = "my_s3_policy"
  role   = aws_iam_role.glue.id
  policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    actions = ["s3:*"]
    effect  = "Allow"
    resources = [
      "arn:aws:s3:::${data.aws_s3_bucket.xgov-data.id}",
      "arn:aws:s3:::${data.aws_s3_bucket.xgov-data.id}/*"
    ]
  }
}






