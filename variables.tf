variable "namespace" {
  description = "value for the namespace"
}

variable "mysql_root_password" {
  description = "value for the mysql root password"
}

variable "service_type" {
  default = "NodePort"
  description = "value for the service type"
}

variable "mysql_image" {
  default = "mysql:5.6"
  description = "value for the mysql image"
}


# backup agent

variable "backup_agent_schedule" {
  default = "0 0 * * *"
  description = "value for the backup agent schedule"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "value for the AWS_ACCESS_KEY_ID"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "value for the AWS_SECRET_ACCESS_KEY"
}

variable "AWS_BUCKET" {
  description = "value for the AWS_BUCKET"
}

variable "S3_PREFIX" {
  description = "value for the S3_PREFIX"
}