resource "azurerm_resource_group" "default" {
  name     = var.rgname
  location = var.location
}


resource "azurerm_service_plan" "default" {
  name                = var.aspname
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  os_type             = "Windows"
  sku_name            = "F1"

}
resource "azurerm_windows_web_app" "default" {
  name                = var.dns_prefix
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  service_plan_id     = azurerm_service_plan.default.id

  site_config {
  always_on                 = false
  application_stack {
    current_stack            = "dotnet"
    dotnet_version           = "v6.0"
  }
  }
}