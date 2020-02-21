provider "ovh" {
  endpoint = "ovh-eu"
}

resource "ovh_cloud_user" "user" {
  project_id  = "2044653399df4877a72b77333c25557e"
  description = "terraform user"
}

provider "openstack" {
  auth_url = "https://auth.cloud.ovh.net/v3"

  user_name = ovh_cloud_user.user.username
  password  = ovh_cloud_user.user.password

  tenant_id = ovh_cloud_user.user.project_id
}

variable "ovh_regions" {
  type        = list(string)
  default     = [
    "DE1",
    "GRA7",
  ]
}

resource "openstack_compute_keypair_v2" "default" {
  name       = "terraform-default"
  region     = each.value
  public_key = file("~/.ssh/id_rsa.pub")
  for_each = toset(var.ovh_regions)
}
