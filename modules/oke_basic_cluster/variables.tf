variable "tenancy_ocid" {}
variable "user_ocid" {
    default = "ocid1.user.oc1............"
}
variable "private_key_path" {
    default = "/Users/...../oci-myapp/rsa-ssh-generated-keys/oci_api_key.pem"
}
variable "compartment_ocid" {}
variable "region" {}
variable "fingerprint" {
    default = "55:fd:36:48:eb:4f:............"
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "lb_subnet_id" {
  description = "The OCID of the existing load balancer subnet"
  type        = string
  default     = ""  # Empty string as default, will be used as fallback
}

variable "postgresql_database" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "myapp"
}

variable "postgresql_username" {
  description = "Username for PostgreSQL"
  type        = string
  default     = "dev"
}

variable "postgresql_password" {
  description = "Password for PostgreSQL user"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "postgresql_pvc_size" {
  description = "Size of the PostgreSQL PVC"
  type        = string
  default     = "20Gi"
}

variable "app_name" {
  description = "The application name for labeling resources"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "The environment name for labeling resources"
  type        = string
  default     = "prod"
}

variable "redis_backup_bucket_name" {
  description = "Name of the OCI bucket for Redis backups"
  type        = string
  default     = "my-app-redis-backup-bucket"
}

variable "github_username" {
  description = "GitHub username for container registry authentication"
  type        = string
  sensitive   = true
}

variable "github_token" {
  description = "GitHub personal access token for container registry authentication"
  type        = string
  sensitive   = true
}

variable "namespaceList" {
  description = "List of namespaces to create common secrets as GitHub registry etc in cluster"
  type        = list(string)
  default     = ["myapp"]
}

