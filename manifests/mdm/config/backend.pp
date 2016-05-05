class scaleio2::mdm::config::backend {
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

  notify { "scaleio2::mdm::config::backend::config->start": }

  $sio_sds.each |$entry| {
    $sds_name               = $entry[0]
    $protection_domain_name = $entry[1]['protection_domain_name']
    $storage_pool_name      = $entry[1]['storage_pool_name']
    $sds_ip                 = $entry[1]['sds_ip']
    $device_name            = $entry[1]['device_name']
    $device_path            = $entry[1]['device_path']

    notify { "scaleio2::mdm::config::backend::config->end: $sds_name, $protection_domain_name, $storage_pool_name, $sds_ip, $device_name, $device_path ": }
    Class['::scaleio2::mdm::config::backend::protection_domain'] ->
    Class['::scaleio2::mdm::config::backend::storage_pool'] ->
    Class['::scaleio2::mdm::config::backend::server'] ->
    Class['::scaleio2::mdm::config::backend::device']
  }

  notify { "scaleio2::mdm::config::backend::config->end": }
}
