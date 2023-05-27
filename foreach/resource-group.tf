resource "azurerm_resource_group" "rgroup" {

    for_each = {
        apps1 = "eastus"
        apps2 = "westus"
        apps3 = "westus2"
    }

    name = "${each.key}-rg"
    location = "East US"
}