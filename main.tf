locals {
  zones = length(data.ibm_is_zones.regional.zones)
  vpc_zones = {
    for zone in range(local.zones) : zone => {
      zone = "${var.region}-${zone + 1}"
    }
  }

  test_time = formatdate("YYYY.MM.DD.hh.mm", timestamp())

}

resource "null_resource" "testing_for_schematics" {
  count = "${lookup(data.external.env.result, "HOME") == "/home/nobody"}" ? 1 : 0

  provisioner "local-exec" {
    command = "echo \"This will run if in Schematics\""
  }
}

resource "null_resource" "testing_for_home" {
  count = "${lookup(data.external.env.result, "HOME") == "~/ryan"}" ? 1 : 0

  provisioner "local-exec" {
    command = "echo \"This will run if in Home environment\""
  }
}

resource "null_resource" "testing_for_tfcloud" {
  count = "${lookup(data.external.env.result, "HOME") == "/home/tfc-agent"}" ? 1 : 0

  provisioner "local-exec" {
    command = "echo \"This will run if in Home environment\""
  }
}

resource "local_file" "output" {
  content = <<EOF
${lookup(data.external.env.result, "HOME")}
EOF

  filename = "deployment.json"
}

# resource "ibm_cos_bucket_object" "tfcloud_environment" {
#   count           = "${lookup(data.external.env.result, "HOME") == "/home/tfc-agent"}" ? 1 : 0
#   bucket_crn      = data.ibm_cos_bucket.terraform.crn
#   bucket_location = var.region
#   content_file    = "${path.module}/deployment.json"
#   key             = "${local.test_time}-tfcloud-file.json"
# }

# resource "ibm_cos_bucket_object" "schematics_environment" {
#   count           = "${lookup(data.external.env.result, "HOME") == "/home/nobody"}" ? 1 : 0
#   bucket_crn      = data.ibm_cos_bucket.terraform.crn
#   bucket_location = var.region
#   content_file    = "${path.module}/deployment.json"
#   key             = "${local.test_time}-schematics-file.json"
# }

resource "ibm_cos_bucket_object" "other_environment" {
  # count           = "${lookup(data.external.env.result, "HOME") == "/home/ryan"}" ? 1 : 0
  bucket_crn      = data.ibm_cos_bucket.terraform.crn
  bucket_location = var.region
  content_file    = "${path.module}/deployment.json"
  key             = "${local.test_time}-${terraform.workspace}-file.json"
}