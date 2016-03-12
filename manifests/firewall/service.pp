class scaleio2::firewall::service inherits scaleio2::firewall {
  notify { "scaleio2::firewall::service->start": }

  service { 'scaleio2::firewall::service':
    name => 'iptables',
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe => File['/etc/sysconfig/iptables'],
  }

  notify { "scaleio2::firewall::service->end": }
}
