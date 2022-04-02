output "instances_workstation" {
  value = module.dns_workstation.*.name
  #value = module.workstation.*.public_ips
}
