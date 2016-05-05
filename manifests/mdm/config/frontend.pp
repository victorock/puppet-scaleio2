class scaleio2::mdm::config::frontend {
  $sio_sdc                = $scaleio2::mdm::config::sio_sdc
  $protection_domain_name = undef
  $storage_pool_name      = undef
  $volume_name            = undef
  $volume_type            = undef
  $volume_size            = undef
  $sdc_ip                 = undef

  contain scaleio2::mdm::config::frontend::volume
  contain scaleio2::mdm::config::frontend::map
  
  notify { "scaleio2::backend::sds::config->start": }

  $sio_sdc.each |$entry| {
    $sdc_ip                 = $entry[0]
    $protection_domain_name = $entry[1]['protection_domain_name']
    $storage_pool_name      = $entry[1]['storage_pool_name']
    $volume_name            = $entry[1]['volume_name']
    $volume_type            = $entry[1]['volume_type']
    $volume_size            = $entry[1]['volume_size']

    Class['::scaleio2::mdm::config::frontend::volume'] ->
    Class['::scaleio2::mdm::config::frontend::map']
  }

  notify { "scaleio2::backend::sds::config->end": }
}
