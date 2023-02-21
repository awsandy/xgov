export AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
cat << EOF > lf-settings.json
{
  "DataLakeSettings": {
    "DataLakeAdmins": [
      {"DataLakePrincipalIdentifier": "arn:aws:iam::${AWS_ACCOUNT}:role/WSParticipantRole"},
      {"DataLakePrincipalIdentifier": "arn:aws:iam::${AWS_ACCOUNT}:role/lf-admin"}
    ],
    "CreateDatabaseDefaultPermissions": [],
    "CreateTableDefaultPermissions": [],
    "TrustedResourceOwners": [],
    "AllowExternalDataFiltering": false
  }
}
EOF
aws lakeformation put-data-lake-settings --cli-input-json file://lf-settings.json --region eu-west-1