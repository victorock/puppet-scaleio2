class scaleio2::sdc::config
  $mdm_ip = $scaleio2::sdc::mdm_ip
) inherits scaleio2::sdc {

  notify { "scaleio2::sdc::config->start": }
  file {'/bin/emc/scaleio/drv_cfg.txt':
    ensure  => present,
    path    => '/bin/emc/scaleio/drv_cfg.txt',
    owner   => 'root',
    mode    => '0644',
    content => epp('scaleio2/sdc/drv_cfg.txt.epp', { 'mdm_ip' => $mdm_ip }),
    notify => Exec['scaleio2::sdc::service'],
  }
  notify { "scaleio2::sdc::config->end": }
}
