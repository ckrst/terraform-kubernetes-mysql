resource "kubernetes_deployment" "mysql_deployment" {
  metadata {
    name = "mysql-deployment"
    labels {
      app = "mysql"
    }
  }
  spec {
    replicas = 1
    selector {
      matchLabels {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels {
          app = "mysql"
        }
      }
      spec {
        containers {
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