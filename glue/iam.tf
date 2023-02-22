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
