terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "null_resource" "get_creds" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${data.azurerm_resource_group.main.name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing"
  }
}

resource "null_resource" "kubectl_apply" {
  depends_on = [helm_release.cert_manager]
  provisioner "local-exec" {
    command = "kubectl apply -f manifests/cluster-issuer.yaml"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
