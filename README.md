# Remote State Config

You can either run the commands bellow to create a storage and tell terraform to storage the state in this remote state, or delete `backend.tf` file, in this case the state will be created in a local file, in this case it can be hard to work with other people.

```bash
RESOURCE_GROUP_NAME=remotestate ##For this example it must not be equal to resource_group on terraform.tfvars.json
STORAGE_ACCOUNT_NAME=remotestatesyncbackend ##Needs to be unique across all azure
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
```

# Commands

terraform apply = Creates the infrastructure
npm run build = Build the code to js(if needed)
func azure functionapp publish syncbackend --javascript = Deploy the function code
