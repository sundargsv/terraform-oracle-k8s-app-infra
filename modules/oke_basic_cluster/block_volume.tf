resource "oci_core_volume" "shared_db_volume" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "shared-db-volume"
  size_in_gbs        = 50
  vpus_per_gb        = "10"

  freeform_tags = {
    "app"         = var.app_name
    "environment" = var.environment
    "managed-by"  = "terraform"
  }
}

# Get availability domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
} 