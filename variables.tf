variable "namespace" {
  description = "value for the namespace"
}

variable "mysql_root_password" {
  description = "value for the mysql root password"
}

variable "service_type" {
  default     = "NodePort"
  description = "value for the service type"
}

variable "mysql_image" {
  default     = "mysql:5.6"
  description = "value for the mysql image"
}

variable "node_name" {
  default     = ""
  description = "value for the node name"
}
variable "storage_class_name" {
  description = "value for the storage class name"
}
variable "volume_size" {
  default     = "10Gi"
  description = "value for the volume size"
}
variable "volume_name" {
  description = "value for the volume name"
}

# backup agent

variable "backup_agent_schedule" {
  default     = "0 0 * * *"
  description = "value for the backup agent schedule"
}

variable "aws_access_key_id" {
  description = "value for the AWS_ACCESS_KEY_ID"
}

variable "aws_secret_access_key" {
  description = "value for the AWS_SECRET_ACCESS_KEY"
}

variable "aws_bucket" {
  description = "value for the AWS_BUCKET"
}

variable "s3_prefix" {
  description = "value for the S3_PREFIX"
}