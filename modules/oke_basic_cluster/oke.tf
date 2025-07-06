module "myapp-oke" {
  # source                      = "github.com/mlinxfeld/terraform-oci-myapp-oke"
  source                        = "/Users/sundarg/Desktop/my-projects/smart-workflow-meta"
  tenancy_ocid                  = var.tenancy_ocid      # Our tenancy OCID     
  compartment_ocid              = var.compartment_ocid  # Compartment OCID where OKE and network will be deployed
  cluster_type                  = "basic"               # Basic cluster
  k8s_version                   = "v1.32.1"
  node_linux_version            = "8.10"
  node_shape                    = "VM.Standard.A1.Flex" # OCI Free Tier
  node_pool_count               = 1
  node_count                    = 2
  node_ocpus                    = 1                     # OCI Free Tier
  node_memory                   = 6                     # OCI Free Tier
  use_existing_vcn              = false                 # Module itself will create all necessary network resources
  is_api_endpoint_subnet_public = true                  # OKE API Endpoint will be public (Internet facing)
  is_lb_subnet_public           = true                  # OKE LoadBalanacer will be public (Internet facing)
  is_nodepool_subnet_public     = false                  # OKE NodePool will be public (Internet facing), because we dont want nodes to be accessed publicly
}

# Save the kubeconfig to a file
resource "local_file" "kubeconfig" {
  content  = module.myapp-oke.KubeConfig
  filename = var.kubeconfig_path
}

