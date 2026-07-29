variable "vip" {
  description = "VIPs to create"
  default     = []

  type = list(object({
    name            = optional(string)
    fosid           = optional(string)
    uuid            = optional(string)
    comment         = optional(string)
    type            = optional(string)
    dns_mapping_ttl = optional(number)
    ldb_method      = optional(string)
    src_filter      = optional(list(string), [])
    src_vip_filter  = optional(string)
    service         = optional(list(string), [])
    extip           = optional(string)
    extaddr         = optional(list(string), [])
    h2_support      = optional(string)
    h3_support      = optional(string)
    quic = optional(object({
      max_idle_timeout           = optional(number)
      max_udp_payload_size       = optional(number)
      active_connection_id_limit = optional(number)
      ack_delay_exponent         = optional(number)
      max_ack_delay              = optional(number)
      max_datagram_frame_size    = optional(number)
      active_migration           = optional(string)
      grease_quic_bit            = optional(string)
    }))
    nat44                   = optional(string)
    nat46                   = optional(string)
    add_nat46_route         = optional(string)
    mappedip                = optional(list(string), [])
    mapped_addr             = optional(string)
    extintf                 = optional(string)
    arp_reply               = optional(string)
    server_type             = optional(string)
    http_redirect           = optional(string)
    persistence             = optional(string)
    nat_source_vip          = optional(string)
    portforward             = optional(string)
    status                  = optional(string)
    protocol                = optional(string)
    extport                 = optional(string)
    mappedport              = optional(string)
    gratuitous_arp_interval = optional(string)
    srcintf_filter          = optional(list(string), [])
    portmapping_type        = optional(string)
    auth_portal             = optional(string)
    auth_virtual_host       = optional(string)
    empty_cert_action       = optional(string)
    user_agent_detect       = optional(string)
    client_cert             = optional(string)
    realservers = optional(list(object({
      id                = optional(number)
      type              = optional(string)
      address           = optional(string)
      ip                = optional(string)
      port              = optional(number)
      status            = optional(string)
      weight            = optional(number)
      holddown_interval = optional(number)
      healthcheck       = optional(string)
      http_host         = optional(string)
      translate_host    = optional(string)
      max_connections   = optional(number)
      monitor           = optional(string)
      client_ip         = optional(string)
      verify_cert       = optional(string)
    })), [])
    http_cookie_domain_from_host          = optional(string)
    http_cookie_domain                    = optional(string)
    http_cookie_path                      = optional(string)
    http_cookie_generation                = optional(string)
    http_cookie_age                       = optional(string)
    http_cookie_share                     = optional(string)
    https_cookie_secure                   = optional(string)
    http_multiplex                        = optional(string)
    http_multiplex_ttl                    = optional(string)
    http_multiplex_max_request            = optional(string)
    http_multiplex_max_concurrent_request = optional(string)
    log_blocked_traffic                   = optional(string)
    http_supported_max_version            = optional(string)
    http_ip_header                        = optional(string)
    http_ip_header_name                   = optional(string)
    outlook_web_access                    = optional(string)
    weblogic_server                       = optional(string)
    websphere_server                      = optional(string)
    ssl_mode                              = optional(string)
    ssl_upstream                          = optional(string)
    ssl_certificate                       = optional(string)
    ssl_server_client_certificate         = optional(string)
    ssl_dh_bits                           = optional(number)
    ssl_algorithm                         = optional(string)
    ssl_cipher_suites = optional(list(object({
      priority = optional(number)
      cipher   = optional(string)
      versions = optional(string)
    })), [])
    ssl_server_algorithm = optional(string)
    ssl_server_cipher_suites = optional(object({
      priority = optional(number)
      cipher   = optional(string)
      versions = optional(string)
    }))
    ssl_pfs                          = optional(string)
    ssl_min_version                  = optional(string)
    ssl_max_version                  = optional(string)
    ssl_server_min_version           = optional(string)
    ssl_server_max_version           = optional(string)
    ssl_accept_ffdhe_groups          = optional(string)
    ssl_send_empty_frags             = optional(string)
    ssl_client_fallback              = optional(string)
    ssl_client_renegotiation         = optional(string)
    ssl_client_session_state_type    = optional(string)
    ssl_client_session_state_timeout = optional(string)
    ssl_client_session_state_max     = optional(string)
    ssl_client_rekey_count           = optional(string)
    ssl_server_renegotiation         = optional(string)
    ssl_server_session_state_type    = optional(string)
    ssl_server_session_state_timeout = optional(string)
    ssl_server_session_state_max     = optional(string)
    ssl_http_location_conversion     = optional(string)
    ssl_http_match_host              = optional(string)
    ssl_http_strip_secure_cookies    = optional(string)
    ssl_hpkp                         = optional(string)
    ssl_hpkp_primary                 = optional(string)
    ssl_hpkp_backup                  = optional(string)
    ssl_hpkp_age                     = optional(string)
    ssl_hpkp_report_uri              = optional(string)
    ssl_hpkp_include_subdomains      = optional(string)
    ssl_hsts                         = optional(string)
    ssl_hsts_age                     = optional(string)
    ssl_hsts_include_subdomains      = optional(string)
    monitor                          = optional(list(string), [])
    max_embryonic_connections        = optional(string)
    color                            = optional(string)
    ipv6_mappedip                    = optional(string)
    ipv6_mappedport                  = optional(string)
    one_click_gslb_server            = optional(string)
    gslb_hostname                    = optional(string)
    gslb_domain_name                 = optional(string)
    gslb_public_ips = optional(list(object({
      index = optional(number)
      ip    = optional(string)
    })), [])
    dynamic_sort_subtable = optional(string)
    get_all_tables        = optional(bool, "false")
    vdomparam             = optional(string)
    update_if_exist       = optional(bool)
  }))

  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ldb_method == null || contains(["static", "round-robin", "weighted", "least-session", "least-rtt", "first-alive", "http-host"], o.ldb_method)]))
    error_message = "Parameter `ldb_method` must be one of `static`, `round-robin`, `weighted`, `least-session`, `least-rtt`, `first-alive`, `http-host`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.src_vip_filter == null || contains(["disable", "enable"], o.src_vip_filter)]))
    error_message = "Parameter `src_vip_filter` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.h2_support == null || contains(["enable", "disable"], o.h2_support)]))
    error_message = "Parameter `h2_support` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.h3_support == null || contains(["enable", "disable"], o.h3_support)]))
    error_message = "Parameter `h3_support` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.max_idle_timeout == null || (o.max_idle_timeout >= 1 && o.max_idle_timeout <= 60000)]))
    error_message = "Parameter `quic.max_idle_timeout` must be in the range 1-60000."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.max_udp_payload_size == null || (o.max_udp_payload_size >= 1200 && o.max_udp_payload_size <= 1500)]))
    error_message = "Parameter `quic.max_udp_payload_size` must be in the range 1200-1500."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.active_connection_id_limit == null || (o.active_connection_id_limit >= 1 && o.active_connection_id_limit <= 8)]))
    error_message = "Parameter `quic.active_connection_id_limit` must be in the range 1-8."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.ack_delay_exponent == null || (o.ack_delay_exponent >= 1 && o.ack_delay_exponent <= 20)]))
    error_message = "Parameter `quic.ack_delay_exponent` must be in the range 1-20."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.max_ack_delay == null || (o.max_ack_delay >= 1 && o.max_ack_delay <= 16383)]))
    error_message = "Parameter `quic.max_ack_delay` must be in the range 1-16383."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.max_datagram_frame_size == null || (o.max_datagram_frame_size >= 1 && o.max_datagram_frame_size <= 1500)]))
    error_message = "Parameter `quic.max_datagram_frame_size` must be in the range 1-1500."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.active_migration == null || contains(["enable", "disable"], o.active_migration)]))
    error_message = "Parameter `quic.active_migration` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.quic == null || o.grease_quic_bit == null || contains(["enable", "disable"], o.grease_quic_bit)]))
    error_message = "Parameter `quic.grease_quic_bit` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.nat44 == null || contains(["disable", "enable"], o.nat44)]))
    error_message = "Parameter `nat44` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.nat46 == null || contains(["disable", "enable"], o.nat46)]))
    error_message = "Parameter `nat46` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.add_nat46_route == null || contains(["disable", "enable"], o.add_nat46_route)]))
    error_message = "Parameter `add_nat46_route` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.arp_reply == null || contains(["disable", "enable"], o.arp_reply)]))
    error_message = "Parameter `arp_reply` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.server_type == null || contains(["http", "https", "imaps", "pop3s", "smtps", "ssl", "tcp", "udp", "ip"], o.server_type)]))
    error_message = "Parameter `server_type` must be one of `http`, `https`, `imaps`, `pop3s`, `smtps`, `ssl`, `tcp`, `udp`, `ip`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.http_redirect == null || contains(["enable", "disable"], o.http_redirect)]))
    error_message = "Parameter `http_redirect` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.persistence == null || contains(["none", "http-cookie", "ssl-session-id"], o.persistence)]))
    error_message = "Parameter `persistence` must be one of `none`, `http-cookie`, `ssl-session-id`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.nat_source_vip == null || contains(["disable", "enable"], o.nat_source_vip)]))
    error_message = "Parameter `nat_source_vip` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.portforward == null || contains(["disable", "enable"], o.portforward)]))
    error_message = "Parameter `portforward` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.status == null || contains(["disable", "enable"], o.status)]))
    error_message = "Parameter `status` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.protocol == null || contains(["tcp", "udp", "sctp", "icmp"], o.protocol)]))
    error_message = "Parameter `protocol` must be one of `tcp`, `udp`, `sctp`, `icmp`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.gratuitous_arp_interval == null || (o.gratuitous_arp_interval >= 0 && o.gratuitous_arp_interval <= 8640000)]))
    error_message = "Parameter `gratuitous_arp_interval` must be in the range 0-8640000."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.portmapping_type == null || contains(["1-to-1", "m-to-n"], o.portmapping_type)]))
    error_message = "Parameter `portmapping_type` must be one of `1-to-1`, `m-to-n`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.auth_portal == null || contains(["disable", "enable"], o.auth_portal)]))
    error_message = "Parameter `auth_portal` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.empty_cert_action == null || contains(["accept", "block", "accept-unmanageable"], o.empty_cert_action)]))
    error_message = "Parameter `empty_cert_action` must be one of `accept`, `block`, `accept-unmanageable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.user_agent_detect == null || contains(["disable", "enable"], o.user_agent_detect)]))
    error_message = "Parameter `user_agent_detect` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.client_cert == null || contains(["disable", "enable"], o.client_cert)]))
    error_message = "Parameter `client_cert` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : [for p in o.realservers : p.type == null || contains(["ip", "address"], p.type)]]))
    error_message = "Parameter `realservers.type` must be one of `ip`, `address`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : [for p in o.realservers : p.status == null || contains(["active", "standby", "disable"], p.status)]]))
    error_message = "Parameter `realservers.status` must be one of `active`, `standby`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : [for p in o.realservers : p.healthcheck == null || contains(["disable", "enable", "vip"], p.healthcheck)]]))
    error_message = "Parameter `realservers.healthcheck` must be one of `disable`, `enable`, `vip`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : [for p in o.realservers : p.translate_host == null || contains(["enable", "disable"], p.translate_host)]]))
    error_message = "Parameter `realservers.translate_host` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : [for p in o.realservers : p.verify_cert == null || contains(["enable", "disable"], p.verify_cert)]]))
    error_message = "Parameter `realservers.verify_cert` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.http_cookie_domain_from_host == null || contains(["disable", "enable"], o.http_cookie_domain_from_host)]))
    error_message = "Parameter `http_cookie_domain_from_host` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.http_cookie_share == null || contains(["disable", "same-ip"], o.http_cookie_share)]))
    error_message = "Parameter `http_cookie_share` must be one of `disable`, `same-ip`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.https_cookie_secure == null || contains(["disable", "enable"], o.https_cookie_secure)]))
    error_message = "Parameter `https_cookie_secure` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.http_multiplex == null || contains(["enable", "disable"], o.http_multiplex)]))
    error_message = "Parameter `http_multiplex` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.log_blocked_traffic == null || contains(["enable", "disable"], o.log_blocked_traffic)]))
    error_message = "Parameter `log_blocked_traffic` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.http_supported_max_version == null || contains(["http1", "http2"], o.http_supported_max_version)]))
    error_message = "Parameter `http_supported_max_version` must be one of `http1`, `http2`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.http_ip_header == null || contains(["enable", "disable"], o.http_ip_header)]))
    error_message = "Parameter `http_ip_header` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.outlook_web_access == null || contains(["disable", "enable"], o.outlook_web_access)]))
    error_message = "Parameter `outlook_web_access` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.weblogic_server == null || contains(["disable", "enable"], o.weblogic_server)]))
    error_message = "Parameter `weblogic_server` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.websphere_server == null || contains(["disable", "enable"], o.websphere_server)]))
    error_message = "Parameter `websphere_server` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_mode == null || contains(["half", "full"], o.ssl_mode)]))
    error_message = "Parameter `ssl_mode` must be one of `half`, `full`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_upstream == null || contains(["enable", "disable"], o.ssl_upstream)]))
    error_message = "Parameter `ssl_upstream` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_dh_bits == null || contains([768, 1024, 1536, 2048, 3072, 4096], o.ssl_dh_bits)]))
    error_message = "Parameter `ssl_dh_bits` must be one of `768`, `1024`, `1536`, `2048`, `3072`, `4096`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_algorithm == null || contains(["high", "medium", "low", "custom"], o.ssl_algorithm)]))
    error_message = "Parameter `ssl_algorithm` must be one of `high`, `medium`, `low`, `custom`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_server_algorithm == null || contains(["high", "medium", "low", "custom", "client"], o.ssl_server_algorithm)]))
    error_message = "Parameter `ssl_server_algorithm` must be one of `high`, `medium`, `low`, `custom`, `client`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_pfs == null || contains(["require", "deny", "allow"], o.ssl_pfs)]))
    error_message = "Parameter `ssl_pfs` must be one of `require`, `deny`, `allow`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_accept_ffdhe_groups == null || contains(["enable", "disable"], o.ssl_accept_ffdhe_groups)]))
    error_message = "Parameter `ssl_accept_ffdhe_groups` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_send_empty_frags == null || contains(["enable", "disable"], o.ssl_send_empty_frags)]))
    error_message = "Parameter `ssl_send_empty_frags` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_client_fallback == null || contains(["disable", "enable"], o.ssl_client_fallback)]))
    error_message = "Parameter `ssl_client_fallback` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_client_renegotiation == null || contains(["allow", "deny", "secure"], o.ssl_client_renegotiation)]))
    error_message = "Parameter `ssl_client_renegotiation` must be one of `allow`, `deny`, `secure`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_client_session_state_type == null || contains(["disable", "time", "count", "both"], o.ssl_client_session_state_type)]))
    error_message = "Parameter `ssl_client_session_state_type` must be one of `disable`, `time`, `count`, `both`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_server_renegotiation == null || contains(["enable", "disable"], o.ssl_server_renegotiation)]))
    error_message = "Parameter `ssl_server_renegotiation` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_server_session_state_type == null || contains(["disable", "time", "count", "both"], o.ssl_server_session_state_type)]))
    error_message = "Parameter `ssl_server_session_state_type` must be one of `disable`, `time`, `count`, `both`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_http_location_conversion == null || contains(["enable", "disable"], o.ssl_http_location_conversion)]))
    error_message = "Parameter `ssl_http_location_conversion` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_http_match_host == null || contains(["enable", "disable"], o.ssl_http_match_host)]))
    error_message = "Parameter `ssl_http_match_host` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_http_strip_secure_cookies == null || contains(["enable", "disable"], o.ssl_http_strip_secure_cookies)]))
    error_message = "Parameter `ssl_http_strip_secure_cookies` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_hpkp == null || contains(["disable", "enable", "report-only"], o.ssl_hpkp)]))
    error_message = "Parameter `ssl_hpkp` must be one of `disable`, `enable`, `report-only`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_hpkp_include_subdomains == null || contains(["disable", "enable"], o.ssl_hpkp_include_subdomains)]))
    error_message = "Parameter `ssl_hpkp_include_subdomains` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_hsts == null || contains(["disable", "enable"], o.ssl_hsts)]))
    error_message = "Parameter `ssl_hsts` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.ssl_hsts_include_subdomains == null || contains(["disable", "enable"], o.ssl_hsts_include_subdomains)]))
    error_message = "Parameter `ssl_hsts_include_subdomains` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.one_click_gslb_server == null || contains(["disable", "enable"], o.one_click_gslb_server)]))
    error_message = "Parameter `one_click_gslb_server` must be one of `disable`, `enable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip : o.dynamic_sort_subtable == null || contains(["false", "true", "natural", "alphabetical"], o.dynamic_sort_subtable)]))
    error_message = "Parameter `dynamic_sort_subtable` must be one of `false`, `true`, `natural`, `alphabetical`."
  }
}

variable "vip6" {
  description = "VIP6s to create"
  default     = []

  type = list(object({
    name           = optional(string)
    fosid          = optional(string)
    uuid           = optional(string)
    comment        = optional(string)
    type           = optional(string)
    src_filter     = optional(list(string), [])
    src_vip_filter = optional(string)
    extip          = string
    mappedip       = string
    nat_source_vip = optional(string)
    ndp_reply      = optional(string)
    arp_reply      = optional(string)
    portforward    = optional(string)
    protocol       = optional(string)
    extport        = optional(string)
    mappedport     = optional(string)
    color          = optional(string)
    ldb_method     = optional(string)
    server_type    = optional(string)
    http_redirect  = optional(string)
    persistence    = optional(string)
    h2_support     = optional(string)
    h3_support     = optional(string)
    quic = optional(object({
      max_idle_timeout           = optional(number)
      max_udp_payload_size       = optional(number)
      active_connection_id_limit = optional(number)
      ack_delay_exponent         = optional(number)
      max_ack_delay              = optional(number)
      max_datagram_frame_size    = optional(number)
      active_migration           = optional(string)
      grease_quic_bit            = optional(string)
    }))
    nat66             = optional(string)
    nat64             = optional(string)
    add_nat64_route   = optional(string)
    auth_virtual_host = optional(string)
    empty_cert_action = optional(string)
    user_agent_detect = optional(string)
    client_cert       = optional(string)
    realservers = optional(list(object({
      id                = optional(number)
      ip                = optional(string)
      port              = optional(number)
      status            = optional(string)
      weight            = optional(number)
      holddown_interval = optional(number)
      healthcheck       = optional(string)
      http_host         = optional(string)
      translate_host    = optional(string)
      max_connections   = optional(number)
      monitor           = optional(string)
      client_ip         = optional(string)
      verify_cert       = optional(string)
    })), [])
    http_cookie_domain_from_host  = optional(string)
    http_cookie_domain            = optional(string)
    http_cookie_path              = optional(string)
    http_cookie_generation        = optional(string)
    http_cookie_age               = optional(number)
    http_cookie_share             = optional(string)
    https_cookie_secure           = optional(string)
    http_multiplex                = optional(string)
    http_ip_header                = optional(string)
    http_ip_header_name           = optional(string)
    outlook_web_access            = optional(string)
    weblogic_server               = optional(string)
    websphere_server              = optional(string)
    ssl_mode                      = optional(string)
    ssl_upstream                  = optional(string)
    ssl_certificate               = optional(string)
    ssl_server_client_certificate = optional(string)
    ssl_dh_bits                   = optional(string)
    ssl_algorithm                 = optional(string)
    ssl_cipher_suites = optional(list(object({
      priority = optional(number)
      cipher   = optional(string)
      versions = optional(string)
    })), [])
    ssl_server_renegotiation = optional(string)
    ssl_server_algorithm     = optional(string)
    ssl_server_cipher_suites = optional(list(object({
      priority = optional(number)
      cipher   = optional(string)
      versions = optional(string)
    })), [])
    ssl_pfs                          = optional(string)
    ssl_min_version                  = optional(string)
    ssl_max_version                  = optional(string)
    ssl_server_min_version           = optional(string)
    ssl_server_max_version           = optional(string)
    ssl_accept_ffdhe_groups          = optional(string)
    ssl_send_empty_frags             = optional(string)
    ssl_client_fallback              = optional(string)
    ssl_client_renegotiation         = optional(string)
    ssl_client_session_state_type    = optional(string)
    ssl_client_session_state_timeout = optional(string)
    ssl_client_session_state_max     = optional(string)
    ssl_client_rekey_count           = optional(string)
    ssl_server_session_state_type    = optional(string)
    ssl_server_session_state_timeout = optional(string)
    ssl_server_session_state_max     = optional(string)
    ssl_http_location_conversion     = optional(string)
    ssl_http_match_host              = optional(string)
    ssl_http_strip_secure_cookies    = optional(string)
    ssl_hpkp                         = optional(string)
    ssl_hpkp_primary                 = optional(string)
    ssl_hpkp_backup                  = optional(string)
    ssl_hpkp_age                     = optional(string)
    ssl_hpkp_report_uri              = optional(string)
    ssl_hpkp_include_subdomains      = optional(string)
    ssl_hsts                         = optional(string)
    ssl_hsts_age                     = optional(string)
    ssl_hsts_include_subdomains      = optional(string)
    monitor                          = optional(list(string), [])
    max_embryonic_connections        = optional(string)
    embedded_ipv4_address            = optional(string)
    ipv4_mappedip                    = optional(string)
    ipv4_mappedport                  = optional(string)
    dynamic_sort_subtable            = optional(string, "natural")
    get_all_tables                   = optional(bool, "false")
    vdomparam                        = optional(string)
    update_if_exist                  = optional(bool)
  }))

  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.src_vip_filter == null || contains(["disen"], o.src_vip_filter)]))
    error_message = "Parameter `src_vip_filter` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.nat_source_vip == null || contains(["disen"], o.nat_source_vip)]))
    error_message = "Parameter `nat_source_vip` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ndp_reply == null || contains(["disen"], o.ndp_reply)]))
    error_message = "Parameter `ndp_reply` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.arp_reply == null || contains(["disen"], o.arp_reply)]))
    error_message = "Parameter `arp_reply` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.portforward == null || contains(["disen"], o.portforward)]))
    error_message = "Parameter `portforward` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.protocol == null || contains(["tcp", "udp", "sctp"], o.protocol)]))
    error_message = "Parameter `protocol` must be one of `tcp`, `udp`, `sctp`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ldb_method == null || contains(["static", "round-robin", "weighted", "least-session", "least-rtt", "first-alive", "http-host"], o.ldb_method)]))
    error_message = "Parameter `ldb_method` must be one of `static`, `round-robin`, `weighted`, `least-session`, `least-rtt`, `first-alive`, `http-host`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.server_type == null || contains(["http", "https", "imaps", "pop3s", "smtps", "ssl", "tcp", "udp", "ip"], o.server_type)]))
    error_message = "Parameter `server_type` must be one of `http`, `https`, `imaps`, `pop3s`, `smtps`, `ssl`, `tcp`, `udp`, `ip`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.http_redirect == null || contains(["endis"], o.http_redirect)]))
    error_message = "Parameter `http_redirect` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.persistence == null || contains(["none", "http-cookie", "ssl-session-id"], o.persistence)]))
    error_message = "Parameter `persistence` must be one of `none`, `http-cookie`, `ssl-session-id`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.h2_support == null || contains(["endis"], o.h2_support)]))
    error_message = "Parameter `h2_support` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.h3_support == null || contains(["endis"], o.h3_support)]))
    error_message = "Parameter `h3_support` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.max_idle_timeout == null || (o.max_idle_timeout >= 1 && o.max_idle_timeout <= 60000)]))
    error_message = "Parameter `quic.max_idle_timeout` must be in the range 1-60000."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.max_udp_payload_size == null || (o.max_udp_payload_size >= 1200 && o.max_udp_payload_size <= 1500)]))
    error_message = "Parameter `quic.max_udp_payload_size` must be in the range 1200-1500."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.active_connection_id_limit == null || (o.active_connection_id_limit >= 1 && o.active_connection_id_limit <= 8)]))
    error_message = "Parameter `quic.active_connection_id_limit` must be in the range 1-8."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.ack_delay_exponent == null || (o.ack_delay_exponent >= 1 && o.ack_delay_exponent <= 20)]))
    error_message = "Parameter `quic.ack_delay_exponent` must be in the range 1-20."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.max_ack_delay == null || (o.max_ack_delay >= 1 && o.max_ack_delay <= 16383)]))
    error_message = "Parameter `quic.max_ack_delay` must be in the range 1-16383."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.max_datagram_frame_size == null || (o.max_datagram_frame_size >= 1 && o.max_datagram_frame_size <= 1500)]))
    error_message = "Parameter `quic.max_datagram_frame_size` must be in the range 1-1500."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.active_migration == null || contains(["enable", "disable"], o.active_migration)]))
    error_message = "Parameter `quic.active_migration` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.quic == null || o.grease_quic_bit == null || contains(["enable", "disable"], o.grease_quic_bit)]))
    error_message = "Parameter `quic.grease_quic_bit` must be one of `enable`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.nat66 == null || contains(["disen"], o.nat66)]))
    error_message = "Parameter `nat66` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.nat64 == null || contains(["disen"], o.nat64)]))
    error_message = "Parameter `nat64` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.add_nat64_route == null || contains(["disen"], o.add_nat64_route)]))
    error_message = "Parameter `add_nat64_route` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.empty_cert_action == null || contains(["accept", "block", "accept-unmanageable"], o.empty_cert_action)]))
    error_message = "Parameter `empty_cert_action` must be one of `accept`, `block`, `accept-unmanageable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.user_agent_detect == null || contains(["disen"], o.user_agent_detect)]))
    error_message = "Parameter `user_agent_detect` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.client_cert == null || contains(["disen"], o.client_cert)]))
    error_message = "Parameter `client_cert` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : [for p in o.realservers : p.status == null || contains(["active", "standby", "disable"], p.status)]]))
    error_message = "Parameter `realservers.status` must be one of `active`, `standby`, `disable`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : [for p in o.realservers : p.healthcheck == null || contains(["disable", "enable", "vip"], p.healthcheck)]]))
    error_message = "Parameter `realservers.healthcheck` must be one of `disable`, `enable`, `vip`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : [for p in o.realservers : p.translate_host == null || contains(["endis"], p.translate_host)]]))
    error_message = "Parameter `realservers.translate_host` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : [for p in o.realservers : p.verify_cert == null || contains(["endis"], p.verify_cert)]]))
    error_message = "Parameter `realservers.verify_cert` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.http_cookie_domain_from_host == null || contains(["disen"], o.http_cookie_domain_from_host)]))
    error_message = "Parameter `http_cookie_domain_from_host` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.http_cookie_share == null || contains(["disable", "same-ip"], o.http_cookie_share)]))
    error_message = "Parameter `http_cookie_share` must be one of `disable`, `same-ip`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.https_cookie_secure == null || contains(["disen"], o.https_cookie_secure)]))
    error_message = "Parameter `https_cookie_secure` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.http_multiplex == null || contains(["endis"], o.http_multiplex)]))
    error_message = "Parameter `http_multiplex` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.http_ip_header == null || contains(["endis"], o.http_ip_header)]))
    error_message = "Parameter `http_ip_header` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.outlook_web_access == null || contains(["disen"], o.outlook_web_access)]))
    error_message = "Parameter `outlook_web_access` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.weblogic_server == null || contains(["disen"], o.weblogic_server)]))
    error_message = "Parameter `weblogic_server` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.websphere_server == null || contains(["disen"], o.websphere_server)]))
    error_message = "Parameter `websphere_server` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_mode == null || contains(["half", "full"], o.ssl_mode)]))
    error_message = "Parameter `ssl_mode` must be one of `half`, `full`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_upstream == null || contains(["endis"], o.ssl_upstream)]))
    error_message = "Parameter `ssl_upstream` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_dh_bits == null || contains(["768", "1024", "1536", "2048", "3072", "4096"], o.ssl_dh_bits)]))
    error_message = "Parameter `ssl_dh_bits` must be one of `768`, `1024`, `1536`, `2048`, `3072`, `4096`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_algorithm == null || contains(["high", "medium", "low", "custom"], o.ssl_algorithm)]))
    error_message = "Parameter `ssl_algorithm` must be one of `high`, `medium`, `low`, `custom`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_server_renegotiation == null || contains(["endis"], o.ssl_server_renegotiation)]))
    error_message = "Parameter `ssl_server_renegotiation` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_server_algorithm == null || contains(["high", "medium", "low", "custom", "client"], o.ssl_server_algorithm)]))
    error_message = "Parameter `ssl_server_algorithm` must be one of `high`, `medium`, `low`, `custom`, `client`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_pfs == null || contains(["require", "deny", "allow"], o.ssl_pfs)]))
    error_message = "Parameter `ssl_pfs` must be one of `require`, `deny`, `allow`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_accept_ffdhe_groups == null || contains(["endis"], o.ssl_accept_ffdhe_groups)]))
    error_message = "Parameter `ssl_accept_ffdhe_groups` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_send_empty_frags == null || contains(["endis"], o.ssl_send_empty_frags)]))
    error_message = "Parameter `ssl_send_empty_frags` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_client_fallback == null || contains(["disen"], o.ssl_client_fallback)]))
    error_message = "Parameter `ssl_client_fallback` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_client_renegotiation == null || contains(["allow", "deny", "secure"], o.ssl_client_renegotiation)]))
    error_message = "Parameter `ssl_client_renegotiation` must be one of `allow`, `deny`, `secure`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_client_session_state_type == null || contains(["disable", "time", "count", "both"], o.ssl_client_session_state_type)]))
    error_message = "Parameter `ssl_client_session_state_type` must be one of `disable`, `time`, `count`, `both`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_server_session_state_type == null || contains(["disable", "time", "count", "both"], o.ssl_server_session_state_type)]))
    error_message = "Parameter `ssl_server_session_state_type` must be one of `disable`, `time`, `count`, `both`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_http_location_conversion == null || contains(["endis"], o.ssl_http_location_conversion)]))
    error_message = "Parameter `ssl_http_location_conversion` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_http_match_host == null || contains(["endis"], o.ssl_http_match_host)]))
    error_message = "Parameter `ssl_http_match_host` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_http_strip_secure_cookies == null || contains(["endis"], o.ssl_http_strip_secure_cookies)]))
    error_message = "Parameter `ssl_http_strip_secure_cookies` must be one of `endis`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_hpkp == null || contains(["disable", "enable", "report-only"], o.ssl_hpkp)]))
    error_message = "Parameter `ssl_hpkp` must be one of `disable`, `enable`, `report-only`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_hpkp_include_subdomains == null || contains(["disen"], o.ssl_hpkp_include_subdomains)]))
    error_message = "Parameter `ssl_hpkp_include_subdomains` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_hsts == null || contains(["disen"], o.ssl_hsts)]))
    error_message = "Parameter `ssl_hsts` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.ssl_hsts_include_subdomains == null || contains(["disen"], o.ssl_hsts_include_subdomains)]))
    error_message = "Parameter `ssl_hsts_include_subdomains` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.embedded_ipv4_address == null || contains(["disen"], o.embedded_ipv4_address)]))
    error_message = "Parameter `embedded_ipv4_address` must be one of `disen`."
  }
  validation {
    condition     = alltrue(flatten([for o in var.vip6 : o.dynamic_sort_subtable == null || contains(["false", "true", "natural", "alphabetical"], o.dynamic_sort_subtable)]))
    error_message = "Parameter `dynamic_sort_subtable` must be one of `false`, `true`, `natural`, `alphabetical`."
  }
}
