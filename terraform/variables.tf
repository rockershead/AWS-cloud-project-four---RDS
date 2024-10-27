variable "db_username" {

  type        = string
  description = "username of database"
  default     = "admin"

}

variable "db_password" {

  type        = string
  description = "password of database"
  default     = "password"

}

variable "db_name" {

  type        = string
  description = "database name"
  default     = "DATABASE_TF"

}



variable "db_port" {

  type        = number
  description = "db port"
  default     = 3306

}

variable "create_user_lambda_function_name" {

  type        = string
  description = "lambda function name"
  default     = "CREATE_USER_TF"

}

variable "create_user_lambda_zip_filename" {
  type        = string
  description = "lambda zip filename"
  default     = "create_user.zip"
}

variable "get_user_lambda_function_name" {

  type        = string
  description = "lambda function name"
  default     = "GET_USER_TF"
}

variable "get_user_lambda_zip_filename" {
  type        = string
  description = "lambda zip filename"
  default     = "get_user.zip"
}
