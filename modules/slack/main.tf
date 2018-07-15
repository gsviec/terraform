
resource "null_resource" "destroy" {
  provisioner "local-exec" {
    when    = "destroy"
    command = "curl -s 'http://consul.staging.rcapp.co:8500/v1/kv/terraform/slack?dc=staging&raw=true' | bash -s '${var.slack_message_destroy}'"
  }
}


resource "null_resource" "notification" {
   triggers {
    timestamp = "${timestamp()}"
  }
   provisioner "local-exec" {
    command = "yes| curl -s 'http://consul.staging.rcapp.co:8500/v1/kv/terraform/slack?dc=staging&raw=true' | bash -s '${var.slack_message_deploy}'"
  }
}
