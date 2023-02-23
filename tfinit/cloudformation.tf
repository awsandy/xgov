resource "aws_cloudformation_stack" "lf-xgov" {
name = "lf-users"
capabilities=["CAPABILITY_IAM","CAPABILITY_NAMED_IAM"]
#  parameters = {
#    VPCCidr = "10.0.0.0/16"
#  }

template_body = <<STACK
{
  "Description": "CloudFormation template to create AWS Lake Formation workshop resources",
  "Resources": {
    "GlueServiceRole": {
      "Type": "AWS::IAM::Role",
      "Properties": {
        "AssumeRolePolicyDocument": {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Effect": "Allow",
              "Principal": {
                "Service": [
                  "glue.amazonaws.com",
                  "lakeformation.amazonaws.com",
                  "firehose.amazonaws.com"
                ]
              },
              "Action": "sts:AssumeRole"
            }
          ]
        },
        "ManagedPolicyArns": [
          "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
        ],
        "Policies": [
          {
            "PolicyName": "LF-Data-Lake-Storage-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "s3:*"
                  ],
                  "Resource": [
                    {
                      "Fn::Join": [
                        "",
                        [
                          "arn:aws:s3:::",
                          {
                            "Ref": "DataLakeBucket"
                          },
                          "/*"
                        ]
                      ]
                    },
                    {
                      "Fn::Join": [
                        "",
                        [
                          "arn:aws:s3:::",
                          {
                            "Ref": "DataLakeBucket"
                          }
                        ]
                      ]
                    }
                  ]
                }
              ]
            }
          },
          {
            "PolicyName": "Glue-Demo-Access-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "s3:*"
                  ],
                  "Resource": [
                    {
                      "Fn::Join": [
                        "",
                        [
                          "arn:aws:s3:::",
                          {
                            "Ref": "LFWorkshopBucket"
                          },
                          "/*"
                        ]
                      ]
                    },
                    {
                      "Fn::Join": [
                        "",
                        [
                          "arn:aws:s3:::",
                          {
                            "Ref": "LFWorkshopBucket"
                          }
                        ]
                      ]
                    }
                  ]
                }
              ]
            }
          },
          {
            "PolicyName": "LF-DataAccess-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "lakeformation:GetDataAccess",
                    "lakeformation:GrantPermissions"
                  ],
                  "Resource": "*"
                }
              ]
            }
          },
          {
            "PolicyName": "LF-Workflow-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "iam:PassRole"
                  ],
                  "Resource": [
                    {
                      "Fn::Join": [
                        "",
                        [
                          "arn:aws:iam::",
                          {
                            "Ref": "AWS::AccountId"
                          },
                          ":role/LF-GlueServiceRole"
                        ]
                      ]
                    },
                    {
                      "Fn::Join": [
                        "",
                        [
                          "arn:aws:iam::",
                          {
                            "Ref": "AWS::AccountId"
                          },
                          ":role/LakeFormationWorkflowRole"
                        ]
                      ]
                    }
                  ]
                }
              ]
            }
          },

          {
            "PolicyName": "LF-GoveredTable-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "lakeformation:StartTransaction",
                    "lakeformation:CommitTransaction",
                    "lakeformation:CancelTransaction",
                    "lakeformation:ExtendTransaction",
                    "lakeformation:DescribeTransaction",
                    "lakeformation:ListTransactions",
                    "lakeformation:StartQueryPlanning",
                    "lakeformation:GetQueryState",
                    "lakeformation:GetWorkUnitResults",
                    "lakeformation:GetWorkUnits",
                    "lakeformation:GetQueryStatistics",
                    "lakeformation:GetTableObjects",
                    "lakeformation:UpdateTableObjects",
                    "lakeformation:DeleteObjectsOnCancel"
                  ],
                  "Resource": "*"
                }
              ]
            }
          }
        ],
        "RoleName": "LF-GlueServiceRole"
      }
    },
    "DataLakeBucket": {
      "Type": "AWS::S3::Bucket",
      "Properties": {
        "BucketName": {
          "Fn::Join": [
            "-",
            [
              "lf-data-lake",
              {
                "Ref": "AWS::AccountId"
              }
            ]
          ]
        }
      }
    },
    "LFWorkshopBucket": {
      "Type": "AWS::S3::Bucket",
      "Properties": {
        "BucketName": {
          "Fn::Join": [
            "-",
            [
              "lf-workshop",
              {
                "Ref": "AWS::AccountId"
              }
            ]
          ]
        }
      }
    }
  },
  "Outputs": {
    "LFDataLakeBucketName": {
      "Description": "Lake Formation Data Lake Bucket Name",
      "Value": {
        "Ref": "DataLakeBucket"
      }
    },
    "LFWorkshopBucketName": {
      "Description": "Lake Formation Workshop Bucket Name",
      "Value": {
        "Ref": "LFWorkshopBucket"
      }
    },
    "AthenaQueryResultLocation": {
      "Description": "Athena Query Result Location",
      "Value": {
        "Fn::Join": [
          "",
          [
            "s3://",
            {
              "Ref": "LFWorkshopBucket"
            },
            "/athena-results/"
          ]
        ]
      }
    },
    "MetadataLocation": {
      "Description": "Metadata Location",
      "Value": {
        "Fn::Join": [
          "",
          [
            "s3://",
            {
              "Ref": "LFWorkshopBucket"
            },
            "/metadata"
          ]
        ]
      }
    }
  }
}
STACK
}