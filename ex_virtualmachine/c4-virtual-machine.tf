resource "azurerm_virtual_machine" "webserver1" {
    name = "WebServer"
    #computer_name = "devmachine"
    resource_group_name = azurerm_resource_group.DemoforVM.name
    location = azurerm_resource_group.DemoforVM.location
    vm_size = "Standard_DS1_v2"
    #admin_username = "admin123"
    network_interface_ids = [ azurerm_network_interface.myconn.id ]

  /*  admin_ssh_key {
      username = "azureuser"
      public_key = file("${path.module}/sshkeys/tfpractise.pem.pub")
    }
  */
    storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "latest"

    }

    storage_os_disk {
        name = "osdisk"
        caching = "ReadWrite"
        #storage_account_type = "Standard_LRS"
        create_option = "FromImage"
        managed_disk_type = "Standard_LRS"
    }



    os_profile {
      computer_name = "NewMachine"
      admin_username = "admin123"
      admin_password = "admin123!"
    }

    os_profile_linux_config {
      disable_password_authentication = false
    }

    tags = {
      environment = "DemoVM"
    }

}
