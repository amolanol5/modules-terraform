variable "namespace" {
  type        = string
  description = "Name of the environment for the deployment"
}

variable "function_name" {
  type        = string
  description = "Name of the function. Please keep it as concise and short as possible"
}

variable "iam_role_id" {
  type = string
}

variable "enable_xray_traces" {
  type        = bool
  description = "Whether to to sample and trace a subset of incoming requests with AWS X-Ray"
  default     = true
}

variable "s3_bucket" {
  type        = string
  description = "Bucket where the lambda package will reside"
}

variable "handler" {
  type        = string
  description = "Handler string for the function"
}

variable "iam_role_arn" {
  type = string
}

variable "runtime" {
  type    = string
  default = "nodejs12.x"
}

variable "lambda_memory_size" {
  type        = string
  description = "Number of MB to set as RAM for the lambda function"
  default     = "128"
}

variable "lambda_timeout" {
  type        = string
  description = "Number of seconds to set as timeout for the lambda function"
  default     = "35"
}

variable "lambda_layers" {
  type        = list(string)
  description = "List of layers to set for the Lambda function"
  default     = null
}

variable "env_variables" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to describe resources in this module"
}
