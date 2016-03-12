class scaleio2::mdm::config::backend inherits scaleio2::mdm::config {
  $password               = $scaleio2::mdm::config::password
  $mdm_ip                 = $scaleio2::mdm::config::mdm_ip
  $sio_sds                = $scaleio2::mdm::config::sio_sds
  $protection_domain_name = undef
  $storage_pool_name      = undef
  $sds_name               = undef
  $sds_ip                 = undef
  $device_name            = undef
  $device_path            = undef

  contain scaleio2::mdm::config::backend::protection_domain
  contain scaleio2::mdm::config::backend::storage_pool
  contain scaleio2::mdm::config::backend::server
  contain scaleio2::mdm::config::backend::device
  
  $entries = $sio_sds.map |$line| { split($line, ',') }
  $servers =  $entries.slice(6).reduce( {} ) | Hash $s1, Hash $s2, Hash $s3, Hash $s4, Hash $s5, Hash $s6 | { $s1 + $s2 + $s3 + $s4 + $s5 + $s6}

  notify { "scaleio2::mdm::config::backend::config->start": }
  $servers.each |$protection_domain_name| {
    Class['::scaleio2::mdm::config::backend::protection_domain']:
    $protection_domain_name.each |$storage_pool_name| {
      Class['::scaleio2::mdm::config::backend::storage_pool']
      $storage_pool_name.each |$sds_name| {
        $sds_name.each |$sds_ip| {
          Class['::scaleio2::mdm::config::backend::server']
          $sds_ip.each |$device_name| {
            $device_name.each |$device_path| {
              Class['::scaleio2::mdm::config::backend::device']
            }
          }
        }
      }
    }
  }

  notify { "scaleio2::mdm::config::backend::config->end": }
}
