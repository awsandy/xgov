resource "aws_cloudformation_stack" "lf-users" {
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
          "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
          "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"

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
    "AmazonKinesisFirehoseFullAccess": {
      "Type": "AWS::IAM::Role",
      "Properties": {
        "AssumeRolePolicyDocument": {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Effect": "Allow",
              "Principal": {
                "Service": [
                  "firehose.amazonaws.com"
                ]
              },
              "Action": "sts:AssumeRole"
            }
          ]
        },
        "ManagedPolicyArns": [
          "arn:aws:iam::aws:policy/AmazonKinesisFirehoseFullAccess"
        ],
        "Policies": [
          {
            "PolicyName": "LF-Stream-Data-Storage-Policy",
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
          }
        ],
        "RoleName": "LF-KinesisServiceRole"
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
    },
    "LFUsersPassword":{
      "Type":"AWS::SecretsManager::Secret",
      "Properties":{
        "Description":"Secret password for all workshop users",
        "Name":{
          "Fn::Sub":"$${AWS::StackName}-lf-users-credentials"
        },
        "GenerateSecretString":{
          "SecretStringTemplate":"{\"username\":\"all-lf-users\"}",
          "GenerateStringKey":"password",
          "PasswordLength":16,
          "ExcludeCharacters":"\"@/\\"
        }
      }
    },

    "AdminUser": {
      "Type": "AWS::IAM::User",
      "Properties": {
        "Path": "/",
        "LoginProfile": {
          "Password": {
            "Fn::Sub":"{{resolve:secretsmanager:$${LFUsersPassword}::password}}"
          },
          "PasswordResetRequired": false
        },
        "Policies": [
          {
            "PolicyName": "LF-DataLake-Admin-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": "iam:CreateServiceLinkedRole",
                  "Resource": "*",
                  "Condition": {
                    "StringEquals": {
                      "iam:AWSServiceName": "lakeformation.amazonaws.com"
                    }
                  }
                },
                {
                  "Effect": "Allow",
                  "Action": [
                    "iam:PutRolePolicy"
                  ],
                  "Resource": {
                    "Fn::Join":[
                      "",
                      [
                        "arn:aws:iam::",
                        {
                          "Ref":"AWS::AccountId"
                        },
                        ":role/aws-service-role/lakeformation.amazonaws.com/AWSServiceRoleForLakeFormationDataAccess"
                      ]
                    ]
                  }
                },
                {
                  "Effect": "Allow",
                  "Action": "iam:PassRole",
                  "Resource": [
                    "arn:aws:iam::*:role/LF-GlueServiceRole"
                  ]
                }
              ]
            }
          },
          {
            "PolicyName" : "LF-DataLake-Admin-RAM-Invitation-Policy",
            "PolicyDocument" : {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "ram:AcceptResourceShareInvitation",
                    "ram:RejectResourceShareInvitation",
                    "ec2:DescribeAvailabilityZones",
                    "ram:EnableSharingWithAwsOrganization"
                  ],
                  "Resource": "*"
                }
              ]
            }


          }
        ],
        "ManagedPolicyArns": [
          "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin",
          "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
          "arn:aws:iam::aws:policy/AWSLakeFormationCrossAccountManager"
        ],
        "UserName": "lf-admin"
      }
    },
    "DeveloperUser": {
      "Type": "AWS::IAM::User",
      "Properties": {
        "Path": "/",
        "LoginProfile": {
          "Password": {
            "Fn::Sub":"{{resolve:secretsmanager:$${LFUsersPassword}::password}}"
          },
          "PasswordResetRequired": false
        },
        "Policies": [
          {
            "PolicyName": "LF-Athena-Query-Result-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "s3:Put*",
                    "s3:Get*",
                    "s3:List*"
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
                          "/athena-results/*"
                        ]
                      ]
                    }
                  ]
                }
              ]
            }
          },
          {
            "PolicyName": "LF-Cell-Level-Filter-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "lakeformation:StartQueryPlanning",
                    "lakeformation:GetQueryState",
                    "lakeformation:GetWorkUnits",
                    "lakeformation:GetWorkUnitResults"
                  ],
                  "Resource": "*"
                }
              ]
            }
          }
        ],
        "ManagedPolicyArns": [
          "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
        ],
        "UserName": "lf-developer"
      }
    },
    "CampaignManagerUser": {
      "Type": "AWS::IAM::User",
      "Properties": {
        "Path": "/",
        "LoginProfile": {
          "Password": {
            "Fn::Sub":"{{resolve:secretsmanager:$${LFUsersPassword}::password}}"
          },
          "PasswordResetRequired": false
        },
        "Policies": [
          {
            "PolicyName": "LF-Athena-Query-Result-Policy",
            "PolicyDocument": {
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "s3:Put*",
                    "s3:Get*",
                    "s3:List*"
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
                          "/athena-results/*"
                        ]
                      ]
                    }
                  ]
                }
              ]
            }
          }
        ],
        "ManagedPolicyArns": [
          "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
        ],
        "UserName": "lf-campaign-manager"
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
    },
    "LFUsersCredentials":{
      "Description":"AWS Secrets Manager Secret Name for all workshop users credentials",
      "Value":{
        "Fn::Sub":"https://$${AWS::Region}.console.aws.amazon.com/secretsmanager/secret?name=$${AWS::StackName}-lf-users-credentials"
      }
    }
  }
}
STACK
}