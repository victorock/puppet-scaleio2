class scaleio2::mdm::config::frontend inherits scaleio2::mdm::config {
  $sio_sdc                = $scaleio2::mdm::config::sio_sdc
  $protection_domain_name = undef
  $storage_pool_name      = undef
  $volume_name            = undef
  $volume_type            = undef
  $volume_size            = undef
  $sdc_ip                 = undef

  contain scaleio2::mdm::config::frontend::map
  contain scaleio2::mdm::config::frontend::volume

  $entries = $sio_sdc.map |$line| { split($line, ',') }
  $clients =  $entries.slice(6).reduce( {} ) | Hash $s1, Hash $s2, Hash $s3, Hash $s4, Hash $s5, Hash $s6 | { $s1 + $s2 + $s3 + $s4 + $s5 + $s6 }

  notify { "scaleio2::backend::sds::config->start": }

  $servers.each |$protection_domain_name| {
    $protection_domain_name.each |$storage_pool_name| {
      $storage_pool_name.each |$volume_name| {
        $volume_name.each |$volume_type| {
          $volume_type.each |$volume_size| {
            class['scaleio2::mdm::config::frontend::volume']
            $volume_type.each |$sdc_ip| {
              class['scaleio2::mdm::config::frontend::map']
          }
        }
      }
    }
  }

  notify { "scaleio2::backend::sds::config->end": }
}
