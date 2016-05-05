class scaleio2::sds::config {
  $sds_ssd_env_flag        = $scaleio2::sds::sds_ssd_env_flag
  $sio_sds_network         = $scaleio2::sds::sio_sds_network

  notify { "scaleio2::sds::config->start": } ->

  file_line { 'Append a CONF=IOPS line to /etc/environment':
      path => '/etc/environment',
      match => "^CONF=",
      line => "CONF=IOPS",
      notify  => Service['scaleio2::sds::service'],
  } ->

  file_line { 'Append a FACTER_scaleio_sds_network line to /etc/environment':
      path => '/etc/environment',
      match => "^FACTER_scaleio_sds_network=",
      line => "FACTER_scaleio_sds_network=${sio_sds_network}",
      notify  => Service['scaleio2::sds::service'],
  } ->

  notify { "scaleio2::sds::config->end": }
}
