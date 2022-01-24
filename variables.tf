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