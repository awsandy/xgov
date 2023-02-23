resource "aws_lakeformation_resource_lf_tags" "db-xgov" {
  database {
    name = "xgov"
  }

  lf_tag {
    key   = "sensitivity"
    value = "confidential"
  }
}


resource "aws_lakeformation_resource_lf_tags" "tables-xgov" {
  table {
    database_name=aws_lakeformation_resource_lf_tags.db-xgov.database
    wildcard=true
  }

  lf_tag {
    key   = "sensitivity"
    value = "confidential"
  }
}

resource "aws_lakeformation_resource_lf_tags" "table-customer-public" {
  table {
    database_name=aws_lakeformation_resource_lf_tags.db-xgov.database
    name="customers"
    column_names=["Customer_ID"]
  }

  lf_tag {
    key   = "sensitivity"
    value = "public"
  }
}


resource "aws_lakeformation_resource_lf_tags" "table-customer-public" {
  table {
    database_name=aws_lakeformation_resource_lf_tags.db-xgov.database
    name="customers"
    column_names=["customer_id"]
  }

  lf_tag {
    key   = "sensitivity"
    value = "public"
  }
}

resource "aws_lakeformation_resource_lf_tags" "table-customer-private" {
  table {
    database_name=aws_lakeformation_resource_lf_tags.db-xgov.database
    name="customers"
    column_names=["prefix","first_name","middle_name","last_name","suffix","gender"]
  }

  lf_tag {
    key   = "sensitivity"
    value = "public"
  }
}

resource "aws_lakeformation_resource_lf_tags" "table-customer-confidential" {
  table {
    database_name=aws_lakeformation_resource_lf_tags.db-xgov.database
    name="customers"
    column_names=["dob","address"]
  }

  lf_tag {
    key   = "sensitivity"
    value = "public"
  }
}

