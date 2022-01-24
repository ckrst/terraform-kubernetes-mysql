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
      match_labels = {
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
          image = var.mysql_image
          port {
            container_port = 3306
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

resource "kubernetes_service" "mysql_service" {
  metadata {
    name = "mysql-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "${kubernetes_deployment.mysql_deployment.spec.0.template.0.metadata.0.labels.app}"
    }
    port {
      port        = 3306
      target_port = 3306
    }

    type = var.service_type
  }
}