resource "kubernetes_namespace" "postgresql" {
  metadata {
    name = "postgresql"
  }
}

resource "helm_release" "postgresql" {
  name       = "myapp-postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.postgresql.metadata[0].name
  version    = "12.5.3"  # Using a stable version

  values = [
    templatefile("${path.module}/values/postgresql-values.yaml", {
      database = var.postgresql_database
      username = var.postgresql_username
      password = var.postgresql_password
      # persistence_existing_claim = kubernetes_persistent_volume_claim.shared_db_pvc.metadata[0].name
      persistence_existing_claim = "shared-db-pvc"
      app_name = var.app_name
      environment = var.environment
      init_script = file("${path.module}/values/postgresql-init/01-grant-privileges.sql")
    })
  ]

  # Add timeouts for Helm operations
  timeout = 600
  wait    = true

  depends_on = [
    kubernetes_namespace.postgresql
  ]
} 