resource "kubernetes_persistent_volume" "shared_db_pv" {
  metadata {
    name = "shared-db-pv"
    labels = {
      app       = var.app_name
      env       = var.environment
      type      = "shared-db"
    }
  }

  spec {
    capacity = {
      storage = "50Gi"
    }
    volume_mode = "Filesystem"
    access_modes = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = ""  # No storage class, using static provisioning
    
    persistent_volume_source {
      csi {
        driver        = "blockvolume.csi.oraclecloud.com"
        volume_handle = oci_core_volume.shared_db_volume.id
        fs_type       = "ext4"
      }
    }
  }
} 

/*
resource "kubernetes_persistent_volume_claim" "shared_db_pvc" {
  metadata {
    name = "shared-db-pvc"
    namespace = "postgresql"  # replace or set directly if needed
     labels = {
      app       = var.app_name
      env       = var.environment
      type      = "shared-db"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "50Gi"
      }
    }

    volume_name = kubernetes_persistent_volume.shared_db_pv.metadata[0].name
    storage_class_name = ""  # Important: must match PV's storage class (empty for static binding)
  }
}
*/

/*
resource "kubernetes_persistent_volume_claim" "shared_db_pvc" {
  metadata {
    name      = "shared-db-pvc"
    namespace = "postgresql"
    labels = {
      app       = var.app_name
      env       = var.environment
      component = "database"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "50Gi"
      }
    }

    volume_name         = "shared-db-pv"
    storage_class_name  = null  # <- THIS is the key fix
  }
}
*/

resource "kubernetes_manifest" "shared_db_pvc" {
  manifest = yamldecode(file("${path.module}/shared-db-pvc.yaml"))
}