
output "KubeConfig" {
  value = module.myapp-oke.KubeConfig
}

output "Cluster" {
  value = module.myapp-oke.cluster
}

output "NodePool" {
  value = module.myapp-oke.node_pool
}
