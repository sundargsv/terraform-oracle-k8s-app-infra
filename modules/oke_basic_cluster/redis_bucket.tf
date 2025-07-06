# Create OCI bucket for Redis backups
resource "oci_objectstorage_bucket" "redis_backups" {
  compartment_id = var.compartment_ocid
  name          = var.redis_backup_bucket_name
  namespace     = data.oci_objectstorage_namespace.ns.namespace
  access_type   = "NoPublicAccess"
  versioning    = "Disabled"
  storage_tier  = "Standard"
}

# Create lifecycle policy for the bucket
resource "oci_objectstorage_object_lifecycle_policy" "redis_backups_lifecycle" {
  namespace = data.oci_objectstorage_namespace.ns.namespace
  bucket    = oci_objectstorage_bucket.redis_backups.name

  rules {
    name        = "my-app-redis-backup-delete-old-backups"
    is_enabled  = true
    action      = "DELETE"
    target      = "objects"
    time_unit   = "DAYS"
    time_amount = 7
  }
}

# Get the namespace for the bucket
data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_ocid
}

# Create IAM policy for Object Storage service
resource "oci_identity_policy" "object_storage_policy" {
  compartment_id = var.tenancy_ocid
  name          = "my-app-redis-backup-policy"
  description   = "Policy for Object Storage service access for Redis backups"
  statements    = [
    "Allow service objectstorage-ap-hyderabad-1 to manage object-family in tenancy"
  ]
} 