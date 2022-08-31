locals {
  lambda_key       = "${var.namespace}-${var.function_name}-src.zip"
}

# Lambda Function

data "aws_iam_policy_document" "logging_for_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy_document" "edge_permissions" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:GetFunction",
      "lambda:EnableReplication*",
      "iam:CreateServiceLinkedRole"
    ]

    resources = ["${aws_lambda_function.main.arn}"]
  }
}


# Enables CloudWatch logs
resource "aws_iam_role_policy" "logging_for_lambda" {
  name = "${var.namespace}-lambda-logging"
  role = var.iam_role_id

  policy = data.aws_iam_policy_document.logging_for_lambda.json

}

resource "aws_iam_role_policy" "edge_permissions" {
  name = "${var.namespace}-edge_permissions"
  role = var.iam_role_id

  policy = data.aws_iam_policy_document.edge_permissions.json
}

resource "aws_s3_bucket_object" "hello_world_package" {
  bucket = var.s3_bucket
  key    = local.lambda_key
  source = "${path.module}/src/hello-world.zip"
  etag   = filemd5("${path.module}/src/hello-world.zip")
}


resource "aws_lambda_function" "main" {
  function_name = "${var.namespace}-${var.function_name}"
  s3_bucket     = var.s3_bucket
  s3_key        = local.lambda_key
  handler       = var.handler
  role          = var.iam_role_arn
  runtime       = var.runtime
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  layers        = var.lambda_layers
  publish       = true



  depends_on = [aws_s3_bucket_object.hello_world_package]

  lifecycle {
    ignore_changes = [
      environment,
      function_name,
      s3_key,
      s3_bucket,
      last_modified
    ]
  }

  tags = var.tags
}


# # permission for execution lambda edge from cloudfront
# resource "aws_lambda_permission" "with_edge" {
#   statement_id  = "replicator-lambda-GetFunction"
#   action        = "lambda:GetFunction"
#   function_name = aws_lambda_function.main.function_name
#   principal     = "replicator.lambda.amazonaws.com"
#   source_arn    = aws_lambda_function.main.arn
# }


# # ------------execution role
# resource "aws_iam_role" "iam_for_lambda_edge" {
#   name = "${local.environment}-lambda-edge-assume-policy-role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
#       },
#       "Effect": "Allow",
#       "Sid": "exectionRole"
#     }
#   ]
# }
# EOF
# }






















