resource "aws_lakeformation_resource_lf_tags" "db-xgov" {
  database {
    name = "xgov"
  }

  lf_tag {
    key   = aws_lakeformation_lf_tag.tags-xgov.key
    value = "confidential"
  }
}


resource "aws_lakeformation_resource_lf_tags" "tables-xgov" {
  table {
    database_name="xgov"
    name="customers"
  }

  lf_tag {
    key   = aws_lakeformation_lf_tag.tags-xgov.key
    value = "confidential"
  }
}

resource "aws_lakeformation_resource_lf_tags" "table-customer-public" {
  table_with_columns {
    database_name="xgov"
    name="customers"
    column_names=["Customer_ID"]
  }

  lf_tag {
    key   = aws_lakeformation_lf_tag.tags-xgov.key
    value = "public"
  }
}


resource "aws_lakeformation_resource_lf_tags" "table-customer-private" {
  table_with_columns {
    database_name="xgov"
    name="customers"
    column_names=["prefix","first_name","middle_name","last_name","suffix","gender"]
  }

  lf_tag {
    key   = aws_lakeformation_lf_tag.tags-xgov.key
    value = "private"
  }
}

resource "aws_lakeformation_resource_lf_tags" "table-customer-confidential" {
  table_with_columns {
    database_name="xgov"
    name="customers"
    column_names=["dob","address"]
  }

  lf_tag {
    key   = aws_lakeformation_lf_tag.tags-xgov.key
    value = "confidential"
  }
}

