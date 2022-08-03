terraform {
  backend "azurerm" {
    resource_group_name  = "remotestate"
    storage_account_name = "remotestatesyncbackend"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
