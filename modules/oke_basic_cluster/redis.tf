# Create Redis namespace
resource "kubernetes_namespace" "redis" {
  metadata {
    name = "redis"
  }
  depends_on = [
    oci_objectstorage_bucket.redis_backups,
    oci_objectstorage_object_lifecycle_policy.redis_backups_lifecycle,
    oci_identity_policy.object_storage_policy
  ]
}

# Apply OCI CLI Secret
resource "kubernetes_manifest" "oci_cli_secret" {
  manifest = yamldecode(file("${path.module}/redis/oci-cli-secret.yml"))
  depends_on = [kubernetes_namespace.redis]
}

# Apply Redis deployment
resource "kubernetes_manifest" "redis_deployment" {
  manifest = yamldecode(templatefile("${path.module}/redis/redis-in-memory-backup-ocicli-secret.yml", {
    bucket_name = var.redis_backup_bucket_name
  }))
  depends_on = [
    kubernetes_namespace.redis,
    kubernetes_manifest.oci_cli_secret,
    oci_objectstorage_bucket.redis_backups
  ]
}

# Apply Redis service
resource "kubernetes_manifest" "redis_service" {
  manifest = yamldecode(file("${path.module}/redis/redis-service.yml"))
  depends_on = [
    kubernetes_namespace.redis,
    kubernetes_manifest.redis_deployment
  ]
} 