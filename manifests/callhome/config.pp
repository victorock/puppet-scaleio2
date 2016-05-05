class scaleio2::callhome::config inherits scaleio2::callhome {
  $callhome_cfg   = $scaleio2::callhome::callhome_cfg
  $pkg            = $scaleio2::callhome::pkgs['callhome']

  notify { "scaleio2::callhome::config->start": }

  file { '/opt/emc/scaleio/callhome/cfg/conf.txt':
    path    => '/opt/emc/scaleio/callhome/cfg/conf.txt',
    ensure  => 'present',
    owner   => 'root',
    mode    => '0644',
    require => Package['scaleio2::callhome::install'],
    notify  => Service['scaleio2::callhome::service'],
    content => epp('scaleio2/callhome/callhome.epp', { callhome_cfg => $callhome_cfg }),
  }

  notify { "scaleio2::callhome::config->end": }
}
