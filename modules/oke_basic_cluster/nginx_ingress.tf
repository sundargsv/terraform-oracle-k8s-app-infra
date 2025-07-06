resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.7.1"

  values = [
    templatefile("${path.module}/values/nginx-ingress-values.yaml", {
      lb_subnet_id = coalesce(module.myapp-oke.lb_subnet_id, var.lb_subnet_id)
    })
  ]

  depends_on = [
    module.myapp-oke,
    kubernetes_namespace.ingress_nginx
  ]
} 