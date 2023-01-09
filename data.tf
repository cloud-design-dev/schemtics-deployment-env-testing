data "external" "env" {
  program = ["jq", "-n", "env"]
}

data "ibm_is_zones" "regional" {
  region = var.region
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_resource_instance" "cos_instance" {
  name              = var.cos_instance_name
  resource_group_id = data.ibm_resource_group.group.id
  service           = "cloud-object-storage"
}

data "ibm_cos_bucket" "terraform" {
  bucket_name          = var.existing_bucket_name
  resource_instance_id = data.ibm_resource_instance.cos_instance.id
  bucket_type          = "region_location"
  bucket_region        = var.region
}