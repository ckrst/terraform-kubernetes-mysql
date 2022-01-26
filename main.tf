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

resource "kubernetes_cron_job" "db_backup_agent" {
  metadata {
    name = "db-backup-agent"
    namespace = var.namespace
  }
  spec {
    schedule = var.backup_agent_schedule

    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10

    job_template {
      metadata {
        
      }
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {
            labels = {
              app = "db-backup-agent"
            }
          }
          spec {
            container {
              name = "db-backup-agent"
              image = "perfectweb/mysqldump-to-s3"

              env {
                name = "AWS_ACCESS_KEY_ID"
                value = var.aws_access_key_id
              }

              env {
                name = "AWS_SECRET_ACCESS_KEY"
                value = var.aws_secret_access_key
              }

              env {
                name = "AWS_BUCKET"
                value = var.aws_bucket
              }

              env {
                name = "PREFIX"
                value = "${var.s3_prefix}"
              }

              env {
                name = "MYSQL_ENV_MYSQL_USER"
                value = "root"
              }

              env {
                name = "MYSQL_ENV_MYSQL_PASSWORD"
                value = var.mysql_root_password
              }

              env {
                name = "MYSQL_PORT_3306_TCP_ADDR"
                value = "mysql-service"
              }

              env {
                name = "MYSQL_PORT_3306_TCP_PORT"
                value = "3306"
              }
              
            }
          }
        }
      }
    }
  }
}