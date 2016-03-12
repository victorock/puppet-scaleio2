class scaleio2::firewall::install inherits scaleio2::firewall {
  notify { "scaleio2::firewall::install->start": }

  package { 'scaleio2::firewall::install':
    name => 'iptables',
    ensure => installed,
  }

  notify { "scaleio2::firewall::install->end": }
}
