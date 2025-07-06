# Create the pull secret in kube-system (or any namespace)
resource "kubernetes_secret" "ghcr_pull_secret" {
  metadata {
    name      = "ghcr-pull-secret"
    namespace = "kube-system"
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "ghcr.io" = {
          username = var.github_username
          password = var.github_token
          email    = "${var.github_username}@users.noreply.github.com"
          auth     = base64encode("${var.github_username}:${var.github_token}")
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}

# Create the same pull secret in each namespace
resource "kubernetes_secret" "ghcr_pull_secret_all_ns" {
  for_each = toset(var.namespaceList)

  metadata {
    name      = "ghcr-pull-secret"
    namespace = each.key
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "ghcr.io" = {
          username = var.github_username
          password = var.github_token
          email    = "${var.github_username}@users.noreply.github.com"
          auth     = base64encode("${var.github_username}:${var.github_token}")
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}

# Patch default service account in each namespace to use imagePullSecret
resource "kubernetes_manifest" "patch_service_account" {
  for_each = toset(var.namespaceList)

  manifest = {
    apiVersion = "v1"
    kind       = "ServiceAccount"
    metadata = {
      name      = "default"
      namespace = each.key
    }
    imagePullSecrets = [
      {
        name = "ghcr-pull-secret"
      }
    ]
  }

  depends_on = [kubernetes_secret.ghcr_pull_secret_all_ns]
} 