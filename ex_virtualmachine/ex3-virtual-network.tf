
resource "azurerm_virtual_network" "vnet1" {
    name = "vnetfordemo"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.DemoforVM.location
    resource_group_name = azurerm_resource_group.DemoforVM.name

}


resource "azurerm_subnet"  "subnet1" {
    name = "subnet1"
    resource_group_name = azurerm_resource_group.DemoforVM.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = ["10.0.0.0/24"]

}

resource "azurerm_public_ip" "publicip" {
    name = "publicip1"
    resource_group_name = azurerm_resource_group.DemoforVM.name
    location = azurerm_resource_group.DemoforVM.location
    allocation_method = "Static"
    domain_name_label = "app1-vm-${random_string.myrandom.id}"

    tags =  {
        environment = "DEV"
    }

}


resource "azurerm_network_interface" "myconn" {
    name = "myconn"
    location = azurerm_resource_group.DemoforVM.location
    resource_group_name = azurerm_resource_group.DemoforVM.name

    ip_configuration {
      name = "internal"
      subnet_id = azurerm_subnet.subnet1.id
      private_ip_address_allocation =  "Dynamic"
      public_ip_address_id  = azurerm_public_ip.publicip.id

    }

}