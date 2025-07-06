# Deploy metrics-server using Helm
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.2"

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }

  set {
    name  = "args[1]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }

  values = [
    <<-EOT
    resources:
      requests:
        cpu: 20m
        memory: 50Mi
      limits:
        cpu: 50m
        memory: 100Mi
    EOT
  ]
} 