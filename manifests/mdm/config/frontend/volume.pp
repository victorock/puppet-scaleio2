class scaleio2::mdm::config::frontend::volume {
  $protection_domain_name = $scaleio2::mdm::config::frontend::protection_domain_name
  $storage_pool_name      = $scaleio2::mdm::config::frontend::storage_pool_name
  $volume_name            = $scaleio2::mdm::config::frontend::volume_name
  $volume_size            = $scaleio2::mdm::config::frontend::volume_size

  notify { "scaleio2::mdm::config::frontend::volume->start": }

  exec { "scaleio2::mdm::config::frontend::volume->add: ${protection_domain_name},${storage_pool_name},${volume_name},${volume_size}":
    command => "scli --add_volume --size_gb ${volume_size} --volume_name ${volume_name} --protection_domain_name '${$protection_domain_name}' --storage_pool_name '${storage_pool_name}'",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  => "scli --query_volume --volume_name '${volume_name}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif => "scli --query_protection_domain --protection_domain_name '${$protection_domain_name}'",
  }

  notify { "scaleio2::mdm::config::frontend::volume->end": }
}
