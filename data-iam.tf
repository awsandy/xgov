# this role comes from CloudFormatio
data "aws_iam_role" "LF-GlueServiceRole" {
    name = "LF-GlueServiceRole"
}

data "aws_iam_role" "WSParticipantRole" {
    name = "WSParticipantRole"
}

data "aws_iam_role" "lf-admin" {
    name = "lf-admin"
}

data "aws_s3_bucket" "xgov-data"{
  bucket = format("xgov-data-%s-%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
}