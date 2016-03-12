class scaleio2::mdm::config::backend::protection_domain inherits scaleio2::mdm::config::backend {
  $protection_domain_name = $scaleio2::mdm::config::backend::protection_domain_name

  notify { "scaleio2::mdm::config::backend::protection_domain->start": }

  exec { "scaleio2::mdm::config::backend::protection_domain->add: ${protection_domain_name}":
    command => "scli --add_protection_domain --protection_domain_name '${protection_domain_name}'",
    path    => '/bin',
    unless  => "scli --query_all | grep \"^Protection Domain ${protection_domain_name}\"",
    require => Class['::scaleio::mdm::login'],
  }

  notify { "scaleio2::mdm::config::backend::protection_domain->end": }
}
