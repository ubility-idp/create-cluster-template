resource "helm_release" "ingress" {
  depends_on       = [null_resource.get_creds]
  name             = "${var.prefix}-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-ns"
  create_namespace = true

  set {
    name  = "controller.replicaCount"
    value = 2
  }
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.aks_public_ip.ip_address
  }
}

resource "helm_release" "cert_manager" {
  depends_on       = [helm_release.ingress]
  name             = "${var.prefix}-nginx"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.11.2"

  set {
    name  = "installCRDs"
    value = true
  }
}
