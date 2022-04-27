locals {}

variable "region" {
  default = "us-south"
}

data "external" "env" {
  program = ["jq", "-n", "env"]
}

output "data_home_directory" {
  value = lookup(data.external.env.result, "HOME")
}

resource "null_resource" "testing_for_schematics" {
  count = "${lookup(data.external.env.result, "HOME") == "/home/nobody"}" ? 1 : 0

  provisioner "local-exec" {
    command = "echo \"This will run if in Schematics\""
  }
}

resource "null_resource" "testing_for_home" {
  count = "${lookup(data.external.env.result, "HOME") == "/Users/ryan"}" ? 1 : 0

  provisioner "local-exec" {
    command = "echo \"This will run if in Home environment\""
  }
}

resource "null_resource" "check_for_bash" {
  count = "${lookup(data.external.env.result, "HOME") == "/home/nobody"}" ? 1 : 0

  provisioner "local-exec" {
    command = "which bash"
  }
}

resource "null_resource" "check_for_curl" {
  count = "${lookup(data.external.env.result, "HOME") == "/home/nobody"}" ? 1 : 0

  provisioner "local-exec" {
    command = "which curl"
  }
}

# resource "local_file" "output" {
#   count = "${lookup(data.external.env.result, "HOME") == "/Users/ryan" }" ? 1 : 0
#   content = <<EOF
# ${lookup(data.external.env.result, "HOME")}
# EOF

#   filename = "deployment.env"
# }
