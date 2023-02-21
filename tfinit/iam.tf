# this role comes from CloudFormatio
data "aws_iam_role" "LF-GlueServiceRole" {
    depends_on=[aws_cloudformation_stack.lf-users]
    name = "LF-GlueServiceRole"
}

data "aws_iam_role" "WSParticipantRole" {
    depends_on=[aws_cloudformation_stack.lf-users]
    name = "WSParticipantRole"
}

data "aws_iam_role" "lf-admin" {
    name = "lf-admin"
}


# attach policy allowing acccess to buckets to the Glue role
resource "aws_iam_role_policy" "my_s3_policy2" {
  name   = "my_s3_policy2"
  role   = data.aws_iam_role.LF-GlueServiceRole.id
  policy = data.aws_iam_policy_document.xgov-s3.json
}

data "aws_iam_policy_document" "xgov-s3" {
  statement {
    actions = ["s3:*"]
    effect  = "Allow"
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.xgov-data.id}",
      "arn:aws:s3:::${aws_s3_bucket.xgov-data.id}/*"
    ]
  }
}