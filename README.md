# Requirements

- Azure Client -installed and logged
- Azure Functions Core Tools
- Terraform
- Node.js >= 16

# Variables

Open `terraform.tfvars.json` file and update it with yout subscription_id (when you log into azure client it should print it, or open Azure Portal and search `Subscriptions`), the other inputs may stay the same.

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

terraform init = initializes the terraform
terraform plan = create and display a execution plan
terraform apply = Creates the infrastructure
cd somefunction && npm i && npm run build = install dependencies and builds the code to js(if needed)
func azure functionapp publish syncbackend --javascript = Deploy the function code
