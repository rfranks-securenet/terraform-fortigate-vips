/**
 * # Fortigate VIP configuration module
 *
 * This terraform module configures VIP and VIP6 objects on a firewall
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

# locals {
#   vdom_nats_yaml = {
#     for vdom in var.vdoms : vdom => fileexists("${var.config_path}/${vdom}/nat.yaml") ? yamldecode(file("${var.config_path}/${vdom}/nat.yaml")) : {}
#   }
#
#   nats = flatten([
#     for vdom in var.vdoms : [
#       for name, nat in(local.vdom_nats_yaml[vdom] == null ? {} : local.vdom_nats_yaml[vdom]) : [merge(nat, { name = name, vdom = vdom })]
#     ]
#   ])
# }

resource "fortios_firewall_vip" "vips" {
  for_each                              = { for vip in var.vip : vip.name => vip }
  name                                  = each.value.name
  fosid                                 = each.value.fosid
  uuid                                  = each.value.uuid
  comment                               = each.value.comment
  type                                  = each.value.type
  dns_mapping_ttl                       = each.value.dns_mapping_ttl
  ldb_method                            = each.value.ldb_method
  src_vip_filter                        = each.value.src_vip_filter
  extip                                 = each.value.extip
  h2_support                            = each.value.h2_support
  h3_support                            = each.value.h3_support
  nat44                                 = each.value.nat44
  nat46                                 = each.value.nat46
  add_nat46_route                       = each.value.add_nat46_route
  mapped_addr                           = each.value.mapped_addr
  extintf                               = each.value.extintf
  arp_reply                             = each.value.arp_reply
  server_type                           = each.value.server_type
  http_redirect                         = each.value.http_redirect
  persistence                           = each.value.persistence
  nat_source_vip                        = each.value.nat_source_vip
  portforward                           = each.value.portforward
  status                                = each.value.status
  protocol                              = each.value.protocol
  extport                               = each.value.extport
  mappedport                            = each.value.mappedport
  gratuitous_arp_interval               = each.value.gratuitous_arp_interval
  portmapping_type                      = each.value.portmapping_type
  auth_portal                           = each.value.auth_portal
  auth_virtual_host                     = each.value.auth_virtual_host
  user_agent_detect                     = each.value.user_agent_detect
  client_cert                           = each.value.client_cert
  http_cookie_domain_from_host          = each.value.http_cookie_domain_from_host
  http_cookie_domain                    = each.value.http_cookie_domain
  http_cookie_path                      = each.value.http_cookie_path
  http_cookie_generation                = each.value.http_cookie_generation
  http_cookie_age                       = each.value.http_cookie_age
  http_cookie_share                     = each.value.http_cookie_share
  https_cookie_secure                   = each.value.https_cookie_secure
  http_multiplex                        = each.value.http_multiplex
  http_multiplex_ttl                    = each.value.http_multiplex_ttl
  http_multiplex_max_request            = each.value.http_multiplex_max_request
  http_multiplex_max_concurrent_request = each.value.http_multiplex_max_concurrent_request
  http_supported_max_version            = each.value.http_supported_max_version
  http_ip_header                        = each.value.http_ip_header
  http_ip_header_name                   = each.value.http_ip_header_name
  outlook_web_access                    = each.value.outlook_web_access
  weblogic_server                       = each.value.weblogic_server
  websphere_server                      = each.value.websphere_server
  ssl_mode                              = each.value.ssl_mode
  ssl_upstream                          = each.value.ssl_upstream
  ssl_certificate                       = each.value.ssl_certificate
  ssl_server_client_certificate         = each.value.ssl_server_client_certificate
  ssl_dh_bits                           = each.value.ssl_dh_bits
  ssl_algorithm                         = each.value.ssl_algorithm
  ssl_server_algorithm                  = each.value.ssl_server_algorithm
  ssl_pfs                               = each.value.ssl_pfs
  ssl_min_version                       = each.value.ssl_min_version
  ssl_max_version                       = each.value.ssl_max_version
  ssl_server_min_version                = each.value.ssl_server_min_version
  ssl_server_max_version                = each.value.ssl_server_max_version
  ssl_accept_ffdhe_groups               = each.value.ssl_accept_ffdhe_groups
  ssl_send_empty_frags                  = each.value.ssl_send_empty_frags
  ssl_client_fallback                   = each.value.ssl_client_fallback
  ssl_client_renegotiation              = each.value.ssl_client_renegotiation
  ssl_client_session_state_type         = each.value.ssl_client_session_state_type
  ssl_client_session_state_timeout      = each.value.ssl_client_session_state_timeout
  ssl_client_session_state_max          = each.value.ssl_client_session_state_max
  ssl_client_rekey_count                = each.value.ssl_client_rekey_count
  ssl_server_renegotiation              = each.value.ssl_server_renegotiation
  ssl_server_session_state_type         = each.value.ssl_server_session_state_type
  ssl_server_session_state_timeout      = each.value.ssl_server_session_state_timeout
  ssl_server_session_state_max          = each.value.ssl_server_session_state_max
  ssl_http_location_conversion          = each.value.ssl_http_location_conversion
  ssl_http_match_host                   = each.value.ssl_http_match_host
  ssl_http_strip_secure_cookies         = each.value.ssl_http_strip_secure_cookies
  ssl_hpkp                              = each.value.ssl_hpkp
  ssl_hpkp_primary                      = each.value.ssl_hpkp_primary
  ssl_hpkp_backup                       = each.value.ssl_hpkp_backup
  ssl_hpkp_age                          = each.value.ssl_hpkp_age
  ssl_hpkp_report_uri                   = each.value.ssl_hpkp_report_uri
  ssl_hpkp_include_subdomains           = each.value.ssl_hpkp_include_subdomains
  ssl_hsts                              = each.value.ssl_hsts
  ssl_hsts_age                          = each.value.ssl_hsts_age
  ssl_hsts_include_subdomains           = each.value.ssl_hsts_include_subdomains
  max_embryonic_connections             = each.value.max_embryonic_connections
  color                                 = each.value.color
  ipv6_mappedip                         = each.value.ipv6_mappedip
  ipv6_mappedport                       = each.value.ipv6_mappedport
  one_click_gslb_server                 = each.value.one_click_gslb_server
  gslb_hostname                         = each.value.gslb_hostname
  gslb_domain_name                      = each.value.gslb_domain_name
  dynamic_sort_subtable                 = each.value.dynamic_sort_subtable
  get_all_tables                        = each.value.get_all_tables
  vdomparam                             = each.value.vdomparam
  update_if_exist                       = each.value.update_if_exist

  dynamic "src_filter" {
    for_each = [for o in each.value.src_filter : o]
    content {
      range = src_filter.value
    }
  }

  dynamic "service" {
    for_each = [for o in each.value.service : o]
    content {
      name = service.value
    }
  }

  dynamic "extaddr" {
    for_each = [for o in each.value.extaddr : o]
    content {
      name = extaddr.value
    }
  }

  dynamic "quic" {
    for_each = [for o in each.value.quic : o]
    content {
      max_idle_timeout           = quic.value.max_idle_timeout
      max_udp_payload_size       = quic.value.max_udp_payload_size
      active_connection_id_limit = quic.value.active_connection_id_limit
      ack_delay_exponent         = quic.value.ack_delay_exponent
      max_ack_delay              = quic.value.max_ack_delay
      max_datagram_frame_size    = quic.value.max_datagram_frame_size
      active_migration           = quic.value.active_migration
      grease_quic_bit            = quic.value.grease_quic_bit
    }
  }
  dynamic "mappedip" {
    for_each = [for o in each.value.mappedip : o]
    content {
      range = mappedip.value
    }
  }

  dynamic "srcintf_filter" {
    for_each = [for o in each.value.srcintf_filter : o]
    content {
      interface_name = srcintf_filter.value
    }
  }

  dynamic "realservers" {
    for_each = [for o in each.value.realservers : o]
    content {
      id                = realservers.value.id
      type              = realservers.value.type
      address           = realservers.value.address
      ip                = realservers.value.ip
      port              = realservers.value.port
      status            = realservers.value.status
      weight            = realservers.value.weight
      holddown_interval = realservers.value.holddown_interval
      healthcheck       = realservers.value.healthcheck
      http_host         = realservers.value.http_host
      translate_host    = realservers.value.translate_host
      max_connections   = realservers.value.max_connections
      monitor           = realservers.value.monitor
      client_ip         = realservers.value.client_ip
      verify_cert       = realservers.value.verify_cert
    }
  }

  dynamic "ssl_cipher_suites" {
    for_each = [for o in each.value.ssl_cipher_suites : o]
    content {
      priority = ssl_cipher_suites.value.priority
      cipher   = ssl_cipher_suites.value.cipher
      versions = ssl_cipher_suites.value.versions
    }
  }

  dynamic "ssl_server_cipher_suites" {
    for_each = [for o in each.value.ssl_server_cipher_suites : o]
    content {
      priority = ssl_server_cipher_suites.value.priority
      cipher   = ssl_server_cipher_suites.value.cipher
      versions = ssl_server_cipher_suites.value.versions
    }
  }

  dynamic "monitor" {
    for_each = [for o in each.value.monitor : o]
    content {
      name = monitor.value
    }
  }

  dynamic "gslb_public_ips" {
    for_each = [for o in each.value.gslb_public_ips : o]
    content {
      index = gslb_public_ips.value.index
      ip    = gslb_public_ips.value.ip
    }
  }
}

resource "fortios_firewall_vip6" "vips" {
  for_each                         = { for vip in var.vip6 : vip.name => vip }
  name                             = each.value.name
  fosid                            = each.value.fosid
  uuid                             = each.value.uuid
  comment                          = each.value.comment
  type                             = each.value.type
  src_vip_filter                   = each.value.src_vip_filter
  extip                            = each.value.extip
  mappedip                         = each.value.mappedip
  nat_source_vip                   = each.value.nat_source_vip
  ndp_reply                        = each.value.ndp_reply
  arp_reply                        = each.value.arp_reply
  portforward                      = each.value.portforward
  protocol                         = each.value.protocol
  extport                          = each.value.extport
  mappedport                       = each.value.mappedport
  color                            = each.value.color
  ldb_method                       = each.value.ldb_method
  server_type                      = each.value.server_type
  http_redirect                    = each.value.http_redirect
  persistence                      = each.value.persistence
  h2_support                       = each.value.h2_support
  h3_support                       = each.value.h3_support
  nat66                            = each.value.nat66
  nat64                            = each.value.nat64
  add_nat64_route                  = each.value.add_nat64_route
  auth_virtual_host                = each.value.auth_virtual_host
  user_agent_detect                = each.value.user_agent_detect
  client_cert                      = each.value.client_cert
  http_cookie_domain_from_host     = each.value.http_cookie_domain_from_host
  http_cookie_domain               = each.value.http_cookie_domain
  http_cookie_path                 = each.value.http_cookie_path
  http_cookie_generation           = each.value.http_cookie_generation
  http_cookie_age                  = each.value.http_cookie_age
  http_cookie_share                = each.value.http_cookie_share
  https_cookie_secure              = each.value.https_cookie_secure
  http_multiplex                   = each.value.http_multiplex
  http_ip_header                   = each.value.http_ip_header
  http_ip_header_name              = each.value.http_ip_header_name
  outlook_web_access               = each.value.outlook_web_access
  weblogic_server                  = each.value.weblogic_server
  websphere_server                 = each.value.websphere_server
  ssl_mode                         = each.value.ssl_mode
  ssl_upstream                     = each.value.ssl_upstream
  ssl_certificate                  = each.value.ssl_certificate
  ssl_server_client_certificate    = each.value.ssl_server_client_certificate
  ssl_dh_bits                      = each.value.ssl_dh_bits
  ssl_algorithm                    = each.value.ssl_algorithm
  ssl_server_renegotiation         = each.value.ssl_server_renegotiation
  ssl_server_algorithm             = each.value.ssl_server_algorithm
  ssl_pfs                          = each.value.ssl_pfs
  ssl_min_version                  = each.value.ssl_min_version
  ssl_max_version                  = each.value.ssl_max_version
  ssl_server_min_version           = each.value.ssl_server_min_version
  ssl_server_max_version           = each.value.ssl_server_max_version
  ssl_accept_ffdhe_groups          = each.value.ssl_accept_ffdhe_groups
  ssl_send_empty_frags             = each.value.ssl_send_empty_frags
  ssl_client_fallback              = each.value.ssl_client_fallback
  ssl_client_renegotiation         = each.value.ssl_client_renegotiation
  ssl_client_session_state_type    = each.value.ssl_client_session_state_type
  ssl_client_session_state_timeout = each.value.ssl_client_session_state_timeout
  ssl_client_session_state_max     = each.value.ssl_client_session_state_max
  ssl_client_rekey_count           = each.value.ssl_client_rekey_count
  ssl_server_session_state_type    = each.value.ssl_server_session_state_type
  ssl_server_session_state_timeout = each.value.ssl_server_session_state_timeout
  ssl_server_session_state_max     = each.value.ssl_server_session_state_max
  ssl_http_location_conversion     = each.value.ssl_http_location_conversion
  ssl_http_match_host              = each.value.ssl_http_match_host
  ssl_http_strip_secure_cookies    = each.value.ssl_http_strip_secure_cookies
  ssl_hpkp                         = each.value.ssl_hpkp
  ssl_hpkp_primary                 = each.value.ssl_hpkp_primary
  ssl_hpkp_backup                  = each.value.ssl_hpkp_backup
  ssl_hpkp_age                     = each.value.ssl_hpkp_age
  ssl_hpkp_report_uri              = each.value.ssl_hpkp_report_uri
  ssl_hpkp_include_subdomains      = each.value.ssl_hpkp_include_subdomains
  ssl_hsts                         = each.value.ssl_hsts
  ssl_hsts_age                     = each.value.ssl_hsts_age
  ssl_hsts_include_subdomains      = each.value.ssl_hsts_include_subdomains
  max_embryonic_connections        = each.value.max_embryonic_connections
  embedded_ipv4_address            = each.value.embedded_ipv4_address
  ipv4_mappedip                    = each.value.ipv4_mappedip
  ipv4_mappedport                  = each.value.ipv4_mappedport
  dynamic_sort_subtable            = each.value.dynamic_sort_subtable
  get_all_tables                   = each.value.get_all_tables
  vdomparam                        = each.value.vdomparam
  update_if_exist                  = each.value.update_if_exist


  dynamic "src_filter" {
    for_each = [for o in each.value.src_filter : o]
    content {
      range = src_filter.value
    }
  }

  dynamic "quic" {
    for_each = [for o in each.value.quic : o]
    content {
      max_idle_timeout           = quic.value.max_idle_timeout
      max_udp_payload_size       = quic.value.max_udp_payload_size
      active_connection_id_limit = quic.value.active_connection_id_limit
      ack_delay_exponent         = quic.value.ack_delay_exponent
      max_ack_delay              = quic.value.max_ack_delay
      max_datagram_frame_size    = quic.value.max_datagram_frame_size
      active_migration           = quic.value.active_migration
      grease_quic_bit            = quic.value.grease_quic_bit
    }
  }

  dynamic "realservers" {
    for_each = [for o in each.value.realservers : o]
    content {
      id                = realservers.value.id
      ip                = realservers.value.ip
      port              = realservers.value.port
      status            = realservers.value.status
      weight            = realservers.value.weight
      holddown_interval = realservers.value.holddown_interval
      healthcheck       = realservers.value.healthcheck
      http_host         = realservers.value.http_host
      translate_host    = realservers.value.translate_host
      max_connections   = realservers.value.max_connections
      monitor           = realservers.value.monitor
      client_ip         = realservers.value.client_ip
      verify_cert       = realservers.value.verify_cert
    }
  }

  dynamic "ssl_cipher_suites" {
    for_each = [for o in each.value.ssl_cipher_suites : o]
    content {
      priority = ssl_cipher_suites.value.priority
      cipher   = ssl_cipher_suites.value.cipher
      versions = ssl_cipher_suites.value.versions
    }
  }
  dynamic "ssl_server_cipher_suites" {
    for_each = [for o in each.value.ssl_server_cipher_suites : o]
    content {
      priority = ssl_server_cipher_suites.value.priority
      cipher   = ssl_server_cipher_suites.value.cipher
      versions = ssl_server_cipher_suites.value.versions
    }
  }

  dynamic "monitor" {
    for_each = [for o in each.value.monitor : o]
    content {
      name = monitor.value
    }
  }
}
