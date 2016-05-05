class scaleio2::mdm::config::backend::storage_pool {
  $protection_domain_name = $scaleio2::mdm::config::backend::protection_domain_name
  $storage_pool_name      = $scaleio2::mdm::config::backend::storage_pool_name

  notify { "scaleio2::mdm::config::backend::storage_pool->start": }

  exec { "scaleio2::mdm::config::backend::storage_pool->add: ${protection_domain_name},${storage_pool_name}":
    command => "scli --add_storage_pool --protection_domain_name '${protection_domain_name}' --storage_pool_name '${storage_pool_name}'",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  => "scli --query_storage_pool --protection_domain_name '${protection_domain_name}' --storage_pool_name '${storage_pool_name}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif => "test ! -z '${protection_domain_name}'",
  }

  notify { "scaleio2::mdm::config::backend::storage_pool->end:": }
}
