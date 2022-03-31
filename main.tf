variable "region" {
  default = "us-south"
}

data "external" "env" { program = ["jq", "-n", "env"] }

output "data_raw" {
  value = data.external.env.result
}

output "data_home_directory" {
  value = data.external.env.result.HOME
}