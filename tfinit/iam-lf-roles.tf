resource "aws_iam_role" "lf-developer" {
  name = "lf-developer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        "AWS": format("arn:aws:iam::%s:role/WSParticipantRole",data.aws_caller_identity.current.account_id)
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "lf-developer-attach" {
  role       = aws_iam_role.lf-developer.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_role" "lf-campaign-manager" {
  name = "lf-campaign-manager"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        "AWS": format("arn:aws:iam::%s:role/WSParticipantRole",data.aws_caller_identity.current.account_id)
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "lf-campaign-manager-attach" {
  role       = aws_iam_role.lf-campaign-manager.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}








