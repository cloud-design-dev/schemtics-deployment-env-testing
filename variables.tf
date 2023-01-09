variable "region" {
  description = "IBM Cloud Region to pull data from."
  type        = string
  default     = "us-south"
}

variable "cos_instance_name" {
  description = "Name of the COS instance to pull as data source."
  type        = string
  default     = "rt-2023-cos-instance"
}

variable "resource_group" {
  description = "Name of the resource group to use for data sources."
  type        = string
  default     = "CDE"
}

variable "existing_bucket_name" {
  description = "Name of the bucket to use to store apply output."
  type        = string
  default     = "terraform-deployment-testing-bucket"
}

