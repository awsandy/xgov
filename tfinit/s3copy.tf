resource "aws_s3_object_copy" "customers1" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/customers1.csv"
  source = "event-engine-eu-west-1/xgovdata/customers1.csv"
}

resource "aws_s3_object_copy" "customers2" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/customers2.csv"
  source = "event-engine-eu-west-1/xgovdata/customers2.csv"
}

resource "aws_s3_object_copy" "customers3" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/customers3.csv"
  source = "event-engine-eu-west-1/xgovdata/customers3.csv"
}

resource "aws_s3_object_copy" "products" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/products.csv"
  source = "event-engine-eu-west-1/xgovdata/products.csv"
}

resource "aws_s3_object_copy" "sales" {
  bucket = aws_s3_bucket.xgov-data.id
  key    = "raw-data/sales.csv"
  source = "event-engine-eu-west-1/xgovdata/sales.csv"
}