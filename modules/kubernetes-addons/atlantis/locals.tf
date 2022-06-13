locals {
  name = "atlantis"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://runatlantis.github.io/helm-charts"
    version     = "atlantis-4.0.3"
    namespace   = "kube-system"
    description = "Atlantis helm Chart deployment configuration"
    values      = []
    timeout     = "1200"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
