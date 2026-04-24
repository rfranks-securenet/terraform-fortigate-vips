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

  name                                  = each.value.name
  fosid                                 = try(each.value.fosid, null)
  uuid                                  = try(each.value.uuid, null)
  comment                               = try(each.value.comment, null)
  type                                  = try(each.value.type, "static-nat")
  dns_mapping_ttl                       = try(each.value.dns_mapping_ttl, null)
  ldb_method                            = try(each.value.ldb_method, null)
  src_vip_filter                        = try(each.value.src_vip_filter, null)
  extip                                 = try(each.value.extip, null)
  h2_support                            = try(each.value.h2_support, null)
  h3_support                            = try(each.value.h3_support, null)
  nat44                                 = try(each.value.nat44, null)
  nat46                                 = try(each.value.nat46, null)
  add_nat46_route                       = try(each.value.add_nat46_route, null)
  mapped_addr                           = try(each.value.mapped_addr, null)
  extintf                               = each.value.interface
  arp_reply                             = try(each.value.arp_reply, null)
  server_type                           = try(each.value.server_type, null)
  http_redirect                         = try(each.value.http_redirect, null)
  persistence                           = try(each.value.persistence, null)
  nat_source_vip                        = try(each.value.nat_source_vip, null)
  portforward                           = try(each.value.portforward, null)
  status                                = try(each.value.status, null)
  protocol                              = try(each.value.protocol, null)
  extport                               = try(each.value.extport, null)
  mappedport                            = try(each.value.mappedport, null)
  gratuitous_arp_interval               = try(each.value.gratuitous_arp_interval, null)
  portmapping_type                      = try(each.value.portmapping_type, null)
  empty_cert_action                     = try(each.value.empty_cert_action, null)
  user_agent_detect                     = try(each.value.user_agent_detect, null)
  client_cert                           = try(each.value.client_cert, null)
  http_cookie_domain_from_host          = try(each.value.http_cookie_domain_from_host, null)
  http_cookie_domain                    = try(each.value.http_cookie_domain, null)
  http_cookie_path                      = try(each.value.http_cookie_path, null)
  http_cookie_generation                = try(each.value.http_cookie_generation, null)
  http_cookie_age                       = try(each.value.http_cookie_age, null)
  http_cookie_share                     = try(each.value.http_cookie_share, null)
  https_cookie_secure                   = try(each.value.https_cookie_secure, null)
  http_multiplex                        = try(each.value.http_multiplex, null)
  http_multiplex_ttl                    = try(each.value.http_multiplex_ttl, null)
  http_multiplex_max_request            = try(each.value.http_multiplex_max_request, null)
  http_multiplex_max_concurrent_request = try(each.value.http_multiplex_max_concurrent_request, null)
  http_supported_max_version            = try(each.value.http_supported_max_version, null)
  http_ip_header                        = try(each.value.http_ip_header, null)
  http_ip_header_name                   = try(each.value.http_ip_header_name, null)
  outlook_web_access                    = try(each.value.outlook_web_access, null)
  weblogic_server                       = try(each.value.weblogic_server, null)
  websphere_server                      = try(each.value.websphere_server, null)
  ssl_mode                              = try(each.value.ssl_mode, null)
  ssl_certificate                       = try(each.value.ssl_certificate, null)
  ssl_dh_bits                           = try(each.value.ssl_dh_bits, null)
  ssl_algorithm                         = try(each.value.ssl_algorithm, null)
  ssl_server_algorithm                  = try(each.value.ssl_server_algorithm, null)
  ssl_pfs                               = try(each.value.ssl_pfs, null)
  ssl_min_version                       = try(each.value.ssl_min_version, null)
  ssl_max_version                       = try(each.value.ssl_max_version, null)
  ssl_server_min_version                = try(each.value.ssl_server_min_version, null)
  ssl_server_max_version                = try(each.value.ssl_server_max_version, null)
  ssl_accept_ffdhe_groups               = try(each.value.ssl_accept_ffdhe_groups, null)
  ssl_send_empty_frags                  = try(each.value.ssl_send_empty_frags, null)
  ssl_client_fallback                   = try(each.value.ssl_client_fallback, null)
  ssl_client_renegotiation              = try(each.value.ssl_client_renegotiation, null)
  ssl_client_session_state_type         = try(each.value.ssl_client_session_state_type, null)
  ssl_client_session_state_timeout      = try(each.value.ssl_client_session_state_timeout, null)
  ssl_client_session_state_max          = try(each.value.ssl_client_session_state_max, null)
  ssl_client_rekey_count                = try(each.value.ssl_client_rekey_count, null)
  ssl_server_renegotiation              = try(each.value.ssl_server_renegotiation, null)
  ssl_server_session_state_type         = try(each.value.ssl_server_session_state_type, null)
  ssl_server_session_state_timeout      = try(each.value.ssl_server_session_state_timeout, null)
  ssl_server_session_state_max          = try(each.value.ssl_server_session_state_max, null)
  ssl_http_location_conversion          = try(each.value.ssl_http_location_conversion, null)
  ssl_http_match_host                   = try(each.value.ssl_http_match_host, null)
  ssl_hpkp                              = try(each.value.ssl_hpkp, null)
  ssl_hpkp_primary                      = try(each.value.ssl_hpkp_primary, null)
  ssl_hpkp_backup                       = try(each.value.ssl_hpkp_backup, null)
  ssl_hpkp_age                          = try(each.value.ssl_hpkp_age, null)
  ssl_hpkp_report_uri                   = try(each.value.ssl_hpkp_report_uri, null)
  ssl_hpkp_include_subdomains           = try(each.value.ssl_hpkp_include_subdomains, null)
  ssl_hsts                              = try(each.value.ssl_hsts, null)
  ssl_hsts_age                          = try(each.value.ssl_hsts_age, null)
  ssl_hsts_include_subdomains           = try(each.value.ssl_hsts_include_subdomains, null)
  max_embryonic_connections             = try(each.value.max_embryonic_connections, null)
  color                                 = try(each.value.color, null)
  ipv6_mappedip                         = try(each.value.ipv6_mappedip, null)
  ipv6_mappedport                       = try(each.value.ipv6_mappedport, null)
  one_click_gslb_server                 = try(each.value.one_click_gslb_server, null)
  gslb_hostname                         = try(each.value.gslb_hostname, null)
  gslb_domain_name                      = try(each.value.gslb_domain_name, null)
  dynamic_sort_subtable                 = try(each.value.dynamic_sort_subtable, null)
  get_all_tables                        = try(each.value.get_all_tables, null)
  vdomparam                             = try(each.value.vdomparam, null)
  update_if_exist                       = try(each.value.update_if_exist, null)

  dynamic "src_filter" {
    for_each = { for src_filter in try(each.value.src_filter, []) : src_filter => src_filter }
    content {
      range = src_filter.value
    }
  }

  dynamic "service" {
    for_each = { for service in try(each.value.service, []) : service => service }
    content {
      name = service.value
    }
  }

  dynamic "extaddr" {
    for_each = { for extaddr in try(each.value.extaddr, []) : extaddr => extaddr }
    content {
      name = extaddr.value
    }
  }

  dynamic "quic" {
    for_each = { for quic in try(each.value.quic, []) : index(each.value.quic, quic) => quic }
    content {
      max_idle_timeout           = try(quic.value.max_idle_timeout, null)
      max_udp_payload_size       = try(quic.value.max_udp_payload_size, null)
      active_connection_id_limit = try(quic.value.active_connection_id_limit, null)
      ack_delay_exponent         = try(quic.value.ack_delay_exponent, null)
      max_ack_delay              = try(quic.value.max_ack_delay, null)
      max_datagram_frame_size    = try(quic.value.max_datagram_frame_size, null)
      active_migration           = try(quic.value.active_migration, null)
      grease_quic_bit            = try(quic.value.grease_quic_bit, null)
    }
  }

  dynamic "mappedip" {
    for_each = { for mappedip in try(each.value.mappedip, []) : mappedip => mappedip }
    content {
      range = mappedip.value
    }
  }

  dynamic "srcintf_filter" {
    for_each = { for srcintf_filter in try(each.value.srcintf_filter, []) : srcintf_filter => srcintf_filter }
    content {
      interface_name = srcintf_filter.value
    }
  }

  dynamic "realservers" {
    for_each = { for realservers in try(each.value.realservers, []) : index(each.value.realservers, realservers) => realservers }
    content {
      id                = try(realservers.value.id, null)
      type              = try(realservers.value.type, null)
      address           = try(realservers.value.address, null)
      ip                = try(realservers.value.ip, null)
      port              = try(realservers.value.port, null)
      status            = try(realservers.value.status, null)
      weight            = try(realservers.value.weight, null)
      holddown_interval = try(realservers.value.holddown_interval, null)
      healthcheck       = try(realservers.value.healthcheck, null)
      http_host         = try(realservers.value.http_host, null)
      translate_host    = try(realservers.value.translate_host, null)
      max_connections   = try(realservers.value.max_connections, null)
      monitor           = try(realservers.value.monitor, null)
      client_ip         = try(realservers.value.client_ip, null)
      verify_cert       = try(realservers.value.verify_cert, null)
    }
  }

  dynamic "ssl_cipher_suites" {
    for_each = { for ssl_cipher_suites in try(each.value.ssl_cipher_suites, []) : index(each.value.ssl_cipher_suites, ssl_cipher_suites) => ssl_cipher_suites }
    content {
      priority = try(ssl_cipher_suites.value.priority, null)
      cipher   = try(ssl_cipher_suites.value.cipher, null)
      versions = try(ssl_cipher_suites.value.versions, null)
    }
  }

  dynamic "ssl_server_cipher_suites" {
    for_each = { for ssl_server_cipher_suites in try(each.value.ssl_server_cipher_suites, []) : index(each.value.ssl_server_cipher_suites, ssl_server_cipher_suites) => ssl_server_cipher_suites }
    content {
      priority = try(ssl_server_cipher_suites.value.priority, null)
      cipher   = try(ssl_server_cipher_suites.value.cipher, null)
      versions = try(ssl_server_cipher_suites.value.versions, null)
    }
  }

  dynamic "monitor" {
    for_each = { for monitor in try(each.value.monitor, []) : monitor => monitor }
    content {
      name = monitor.value
    }
  }

  dynamic "gslb_public_ips" {
    for_each = { for gslb_public_ips in try(each.value.gslb_public_ips, []) : index(each.value.gslb_public_ips, gslb_public_ips) => gslb_public_ips }
    content {
      index = try(gslb_public_ips.value.index, null)
      ip    = try(gslb_public_ips.value.ip, null)
    }
  }
}
