class scaleio2::sds::config inherits scaleio2::sds {

  $sds_ssd_env_flag        = $scaleio2::sds::sds_ssd_env_flag
  $sio_sds_network         = $scaleio2::sds::sio_sds_network

  notify { "scaleio2::sds::config->start": }

  if ($sds_ssd_env_flag) {
    file_line { 'Append a CONF=IOPS line to /etc/environment':
        path => '/etc/environment',
        match => "^CONF=",
        line => "CONF=IOPS",
    }
  }

  if ($sio_sds_network) {
    file_line { 'Append a FACTER_scaleio_sds_network line to /etc/environment':
        path => '/etc/environment',
        match => "^FACTER_scaleio_sds_network=",
        line => "FACTER_scaleio_sds_network=${sio_sds_network}",
    }
  }

  
  notify { "scaleio2::sds::config->end": }
}
