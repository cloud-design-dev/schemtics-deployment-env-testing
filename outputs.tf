output "data_home_directory" {
  value = lookup(data.external.env.result, "HOME")
}