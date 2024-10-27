variable "db_username" {

  type        = string
  description = "username of database"


}

variable "db_password" {

  type        = string
  description = "password of database"


}

variable "db_name" {

  type        = string
  description = "database name"


}



variable "db_port" {

  type        = number
  description = "db port"


}

variable "create_user_lambda_function_name" {

  type        = string
  description = "lambda function name"


}

variable "create_user_lambda_zip_filename" {
  type        = string
  description = "lambda zip filename"

}


variable "get_user_lambda_function_name" {

  type        = string
  description = "lambda function name"

}

variable "get_user_lambda_zip_filename" {
  type        = string
  description = "lambda zip filename"

}
