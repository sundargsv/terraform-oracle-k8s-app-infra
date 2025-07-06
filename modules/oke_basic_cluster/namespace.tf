
resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
    labels = {
      name        = "ingress-nginx"
      environment = "production"
      managed-by  = "terraform"
    }
  }

  depends_on = [
    module.myapp-oke
  ]
} 