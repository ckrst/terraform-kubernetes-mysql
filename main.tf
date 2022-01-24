resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name = "mysql-deployment"
    namespace = var.namespace
    labels = {
      app = "mysql"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }
      spec {
        container {
          name = "mysql"
          image = "mysql:5.7"
          ports {
            containerPort = 3306
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = var.mysql_root_password
          }
        }
      }
    }
  }
}