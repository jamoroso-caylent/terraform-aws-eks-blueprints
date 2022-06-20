locals {
  name = "atlantis"
  service_account_name = "atlantis"
  eks_cluster_endpoint = var.addon_context.aws_eks_cluster_endpoint

  set_values = [{
    name  = "serviceAccount.name"
    value = local.service_account_name
    },
    {
      name  = "serviceAccount.create"
      value = false
    }
  ]
  default_helm_config = {
    name        = local.name
    chart       = local.name
    repository  = "https://runatlantis.github.io/helm-charts"
    version     = "4.0.3"
    namespace   = local.name
    description = "Atlantis helm Chart deployment configuration"
    values      = []
    timeout     = "360"
  }
  irsa_config = {
    kubernetes_namespace              = local.helm_config["namespace"]
    kubernetes_service_account        = local.service_account_name
    create_kubernetes_namespace       = true
    create_kubernetes_service_account = true
    irsa_iam_policies                 = concat([aws_iam_policy.atlantis.arn], var.irsa_policies)
  }


  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
    serviceAccountName        = local.service_account_name
    controllerClusterEndpoint = local.eks_cluster_endpoint
  }
}
