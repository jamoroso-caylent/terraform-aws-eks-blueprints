module "helm_addon" {
  source            = "../helm-addon"
  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  irsa_config       = local.irsa_config
  addon_context     = var.addon_context

}

resource "aws_iam_policy" "atlantis" {
  name        = "${var.addon_context.eks_cluster_id}-atlantis"
  description = "IAM Policy for Atlantis"
  policy      = data.aws_iam_policy_document.atlantis.json
}


# resource "kubernetes_namespace_v1" "this" {
#   count = local.helm_config["namespace"] == "kube-system" ? 0 : 1

#   metadata {
#     name = local.helm_config["namespace"]
#     labels = {
#       "app.kubernetes.io/managed-by" = "terraform-aws-eks-blueprints"
#     }
#   }
# }
