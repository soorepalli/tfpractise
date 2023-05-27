resource "azurerm_linux_virtual_machine" "webserver1" {
    count = 2
    name = "WebServer-${count.index}"
    computer_name = "devmachine-${count.index}" #hostname
    resource_group_name = azurerm_resource_group.DemoforVM.name
    location = azurerm_resource_group.DemoforVM.location
    size = "Standard_DS1_v2"
    admin_username = "azureuser"
    #network_interface_ids = [ azurerm_network_interface.myconn.id ]
    network_interface_ids = [element(azurerm_network_interface.myconn[*].id, count.index)]
    #delete_os_disk_on_termination = true

    admin_ssh_key {
      username = "azureuser"
      public_key = file("./sshkeys/tfpractise.pem.pub")
    }


    os_disk {
      name = "osdisk-${count.index}"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
      
    }
  
    source_image_reference {
      publisher = "REDHAT"
      offer  = "RHEL"
      sku = "83-gen2"
      version = "latest"

    }

    #custom_data = filebase64("./app-scripts/app1-cloud-init.txt")

/*
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
*/
    tags = {
      environment = "DemoVM-${count.index}"
    }

}
