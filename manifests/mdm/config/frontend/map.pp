class scaleio2::mdm::config::frontend::map {
  $volume_name  = $scaleio2::mdm::config::frontend::volume_name
  $sdc_ip       = $scaleio2::mdm::config::frontend::sdc_ip

  notify { "scaleio2::mdm::config::frontend::map->start": }

  exec { "scaleio2::mdm::config::frontend::map->add: ${volume_name},${sdc_ip}":
    command => "scli --map_volume_to_sdc --volume_name ${volume_name} --sdc_ip ${sdc_ip} --allow_multi_map",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  => "scli --query_volume --volume_name ${volume_name} | grep SDC | grep 'IP: ${sdc_ip}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif => "test ! -z '${volume_name}'",
  }

  notify { "scaleio2::mdm::config::frontend::map->end": }
}
