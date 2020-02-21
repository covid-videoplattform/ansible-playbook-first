resource "openstack_compute_instance_v2" "controller--testing--thengo--net" {
  name = "controller.testing.thengo.net"

  region = "DE1"

  flavor_name = "s1-2"

  key_pair = "terraform-default"
  user_data       = "#cloud-config\ndisable_root: false"

  image_name = "Debian 10"

  network {
    name = "Ext-Net"
  }

  lifecycle {
    ignore_changes = [
      key_pair,
      user_data
    ]
  }
}

resource "local_file" "controller--testing--thengo--net-info" {
    content  = jsonencode({
      "terraform_vm": openstack_compute_instance_v2.controller--testing--thengo--net
    })
    filename = "../host_vars/controller.testing.thengo.net/terraform-info.json"
}

