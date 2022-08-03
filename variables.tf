variable "resource_group_name" {
  description = "The resource group where the resources should be created."
}

variable "subscription_id" {
  default     = null
  description = "The subscription ID where the resources should be created."
}

variable "location" {
  default     = "brazilsouth"
  description = "The azure datacenter location where the resources should be created."
}

variable "function_app_name" {
  description = "The name for the function app. Should be unique on Azure."
}

variable "account_replication_type" {
  default     = "LRS"
  description = "The Storage Account replication type. See azurerm_storage_account module for posible values."
}

variable "app_settings" {
  default     = {}
  type        = map(string)
  description = "Application settings to insert on creating the function app. Following updates will be ignored, and has to be set manually. Updates done on application deploy or in portal will not affect terraform state file."
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)

  default = {}
}

variable "environment" {
  default     = "dev"
  description = "The environment where the infrastructure is deployed."
}

variable "deployment_slots" {
  description = "Slots to be created on function app."
  type        = list(string)
  default     = []
}

variable "release" {
  default     = ""
  description = "The release the deploy is based on. (Used as a tag on resources)"
}

variable "nodejs_version" {
  default     = "16"
  description = "NodeJS version to use on application"
}

variable "application_insights_retention_days" {
  default     = 30
  type        = number
  description = "Days to keep logs on application insights"
}

variable "logs_retention_days" {
  default     = 7
  type        = number
  description = "Days to keep logs on function app"
}
