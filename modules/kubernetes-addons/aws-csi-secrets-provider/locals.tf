locals {
  name = "csi-secrets-store-provider-aws"

  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://aws.github.io/eks-charts"
    version     = "0.0.3,"
    namespace   = "kube-system"
    timeout     = "1200"
    values      = []
    description = "AWS Secrets Manager and Config Provider for Secret Store CSI Driver"
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
