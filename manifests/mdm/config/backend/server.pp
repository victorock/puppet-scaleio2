class scaleio2::mdm::config::backend::server {
  $protection_domain_name = $scaleio2::mdm::config::backend::protection_domain_name
  $sds_name               = $scaleio2::mdm::config::backend::sds_name
  $sds_ip                 = $scaleio2::mdm::config::backend::sds_ip

  notify { "scaleio2::mdm::config::backend::server->start": }

  exec { "scaleio2::mdm::config::backend::server->add: ${sds_name},${sds_ip},${protection_domain_name}":
      command => "scli --add_sds --sds_name ${sds_name} --sds_ip ${sds_ip} --sds_ip_role all --protection_domain_name '${protection_domain_name}' --i_am_sure",
      path => ["/usr/bin", "/sbin", "/bin"],
      unless  => "scli --query_sds --sds_ip ${sds_ip} | grep ' Name: ${sds_ip}'",
      require => Class['::scaleio2::mdm::config::login'],
      onlyif => "test ! -z '${sds_name}'",
  }

  notify { "scaleio2::mdm::config::backend->end": }
}
