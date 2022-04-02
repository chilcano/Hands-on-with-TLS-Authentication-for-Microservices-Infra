locals {
  adj = jsondecode(file("./adjectives.json"))
}

module "network" {
  count            = 1
  source           = "../modules/network"
  required_subnets = 2
  PlaygroundName   = var.PlaygroundName
}

module "workstation" {
  count              = var.deploy_count
  source             = "../modules/instance"
  PlaygroundName     = var.PlaygroundName
  security_group_ids = [module.network.0.allow_all_security_group_id]
  subnet_id          = module.network.0.public_subnets.0
  instance_type      = var.instance_type
  user_data = templatefile(
    "${var.scriptLocation}/workstation.sh",
    {
      hostname          = "playground"
      username          = "playground"
      ssh_pass          = "March2021"
      gitrepo           = "https://github.com/DevOpsPlayground/Hands-on-with-TLS-Authentication-for-Microservices.git"
    }
  )
  amiName   = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
  amiOwner  = "099720109477"
}

module "dns_workstation" {
  depends_on   = [module.workstation]
  count        = var.deploy_count
  source       = "../modules/dns"
  instances    = var.instances
  instance_ips = element(module.workstation.*.public_ips, count.index)
  domain_name  = var.domain_name
  record_name  = "${element(local.adj, count.index)}-panda"
}
