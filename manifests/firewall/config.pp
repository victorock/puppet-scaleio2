class scaleio2::firewall::config inherits scaleio2::firewall {
  include ::firewall
  include ::scaleio2::firewall::config::gw
  include ::scaleio2::firewall::config::lia
  include ::scaleio2::firewall::config::mdm
  include ::scaleio2::firewall::config::sds
  include ::scaleio2::firewall::config::tb

  notify { "scaleio2::firewall::config->start": }

  firewall { '000 accept all icmp':
      require => undef,
      proto => 'icmp',
      action => 'accept',
  } ->

  firewall { '001 accept all to lo interface':
      require => undef,
      proto => 'all',
      iniface => 'lo',
      action => 'accept',
  }

  notify { "scaleio2::firewall::config->end": }
}
