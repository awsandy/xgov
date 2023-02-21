resource "aws_athena_workgroup" "xgov" {
  name = "xgov"

  configuration {
    enforce_workgroup_configuration    = true

    result_configuration {
      output_location = format("s3://lf-workshop-%s/athena-results/",data.aws_caller_identity.current.account_id)

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}