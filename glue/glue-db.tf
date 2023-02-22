# Error: creating Glue Catalog Database (xgov): 
# AccessDeniedException: Insufficient Lake Formation permission(s): Required Create Database on Catalog
resource "aws_glue_catalog_database" "xgov" {
  name = "xgov"
  
}











