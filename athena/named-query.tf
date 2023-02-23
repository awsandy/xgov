resource "aws_athena_named_query" "foo" {
  name      = "customer-total-sales-by-product"
  workgroup = "xgov"
  database  = "xgov"
  query     = "SELECT p.\"product key\" AS PRODUCTKEY, p.\"product type\" AS PRODUCTTYPE, c.\"customer_id\" AS CUSTOMERID,c.first_name AS FIRSTNAME, c.last_name AS LASTNAME, SUM(s.total_sales) as TOTALSALES FROM sales s inner join customers c on s.customer_id=c.customer_id inner join products p on s.product_id=p.\"product key\" group by 1,2,3,4,5 order by 6 desc"
}