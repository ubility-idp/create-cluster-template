output "load_balancer_ip" {
  value = azurerm_public_ip.aks_public_ip.ip_address
}
