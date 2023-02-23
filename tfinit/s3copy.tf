resource "aws_s3_object_copy" "customers" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/customers/customers.csv"
  source = format("event-engine-eu-west-1/xgovdata/customers%s.csv",var.team_number)
}


resource "aws_s3_object_copy" "products" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/products.csv"
  source = "event-engine-eu-west-1/xgovdata/products/products.csv"
}

resource "aws_s3_object_copy" "sales" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/sales.csv"
  source = "event-engine-eu-west-1/xgovdata/sales/sales.csv"
}