resource "aws_lambda_function" "get_user_lambda" {
  filename         = "${abspath(path.module)}/../../lambdas/get_users/${var.get_user_lambda_zip_filename}"
  source_code_hash = filebase64sha256("${abspath(path.module)}/../../lambdas/get_users/${var.get_user_lambda_zip_filename}")
  role             = aws_iam_role.get_user_lambda_role.arn
  function_name    = var.get_user_lambda_function_name
  handler          = "index.handler" ##change sample_project_lambda according to the python file name
  runtime          = "nodejs18.x"
  timeout          = 30

  description = "Lambda to get users from user table"



  environment {
    variables = {
      DATABASE_NAME = var.db_name
      DB_USERNAME   = var.db_username
      DB_PASSWORD   = var.db_password
      DB_HOST       = aws_db_instance.mydb.address
      DB_PORT       = var.db_port
    }
  }




  depends_on = [
    aws_iam_role.get_user_lambda_role,
    //aws_vpc.main,
    //aws_subnet.private_subnets,
    aws_security_group.rds_security_group,
    aws_db_instance.mydb
  ]
}

resource "aws_iam_role" "get_user_lambda_role" {
  name               = "${var.get_user_lambda_function_name}_role"
  description        = "Lambda execution role for ${var.get_user_lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_get_user_lambda_role.json

  inline_policy {
    name   = "get_user_lambda_lambda_role_policy"
    policy = data.aws_iam_policy_document.get_user_lambda_role_permissions.json
  }
}

data "aws_iam_policy_document" "assume_get_user_lambda_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "get_user_lambda_role_permissions" {




  #Cloudwatch Logs permission required for Lambda
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_get_user_lambda.account_id}:*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_get_user_lambda.account_id}:log-group:/aws/lambda/${var.get_user_lambda_function_name}:*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:ap-southeast-1:${data.aws_caller_identity.current_caller_for_get_user_lambda.account_id}:log-group:/aws/lambda/${var.get_user_lambda_function_name}:log-stream:*"
    ]
    effect = "Allow"
  }


}
