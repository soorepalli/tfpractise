resource "azurerm_linux_virtual_machine" "webserver1" {
    name = "WebServer"
    computer_name = "devmachine"
    resource_group_name = azurerm_resouce_group.DemoforVM.name
    location = azurerm_resouce_group.DemoforVM.location
    size = "Standard_DS1_v2"
    admin_username = "admin123"
    network_interface_ids = [ azurerm_network_interface.myconn.id ]

    admin_ssh_key {
      username = "azureuser"
      public_key = file("${path.module}/sshkeys/tfpractise.pem.pub")
    }

    os_disk {
        name = "osdisk"
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "RedHat"
      offer = "RHEL"
      sku = 83-gen2
      version = latest

    }

}
