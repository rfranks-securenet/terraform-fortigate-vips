/**
 * # Fortigate Policy Objects configuration module
 *
 * This terraform module configures Policy Objects on a firewall
 */
terraform {
  required_version = ">= 1.11.0"
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = ">= 1.22.0"
    }
  }
}

locals {
  vdom_nats_yaml = {
    for vdom in var.vdoms : vdom => fileexists("${var.config_path}/${vdom}/nat.yaml") ? yamldecode(file("${var.config_path}/${vdom}/nat.yaml")) : {}
  }

  nats = flatten([
    for vdom in var.vdoms : [
      for name, nat in(local.vdom_nats_yaml[vdom] == null ? {} : local.vdom_nats_yaml[vdom]) : [merge(nat, { name = name, vdom = vdom })]
    ]
  ])
}

resource "fortios_firewall_vip" "vips" {
  for_each = { for nat in local.nats : nat.name => nat }

  name        = each.value.name
  extintf     = each.value.interface
  extip       = "0.0.0.0"
  type        = "static-nat"
  portforward = try(each.value.port, null) == null ? "disable" : "enable"
  protocol    = try(each.value.protocol, null)
  extport     = try(each.value.port, null)
  mappedport  = try(each.value.mappedport, try(each.value.port, null))
  vdomparam   = each.value.vdom

  mappedip {
    range = each.value.mapped_ip
  }
}
