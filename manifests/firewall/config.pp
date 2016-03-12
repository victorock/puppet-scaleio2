
class scaleio2::firewall::config inherits scaleio2::firewall {
  include ::firewall

  notify { "scaleio2::firewall::config->start": }

  file { '/etc/sysconfig/iptables' :
    path => '/etc/sysconfig/iptables',
    ensure => file,
    owner  => root,
    group  => root,
    notify => Service['scaleio2::firewall::service'],
  } ->

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
