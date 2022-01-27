resource "kubernetes_deployment" "phpmyadmin_deployment" {
  metadata {
    name      = "phpmyadmin-deployment"
    namespace = var.namespace
    labels = {
      app = "phpmyadmin"
    }
  }
  spec {
    replicas = 0
    selector {
      match_labels = {
        app = "phpmyadmin"
      }
    }
    template {
      metadata {
        labels = {
          app = "phpmyadmin"
        }
      }
      spec {
        container {
          name  = "phpmyadmin"
          image = "phpmyadmin:latest"
          port {
            container_port = 80
          }

          env {
            name  = "PMA_HOST"
            value = kubernetes_service.mysql_service.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "phpmyadmin_service" {
  metadata {
    name      = "phpmyadmin-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "${kubernetes_deployment.phpmyadmin_deployment.spec.0.template.0.metadata.0.labels.app}"
    }
    port {
      port        = 80
      target_port = 80
    }

    type = var.service_type
  }
}