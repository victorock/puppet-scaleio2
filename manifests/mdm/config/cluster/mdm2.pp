class scaleio2::mdm::config::cluster::mdm2 {

  $my_ip = $scaleio2::mdm::config::cluster::mdm_ip[1]

  notify { "scaleio2::mdm::config::cluster::mdm2->start": }

  exec { 'scaleio2::mdm::config::cluster::mdm2->add_2nd_mdm':
    command => "scli --add_standby_mdm --new_mdm_ip ${my_ip} --mdm_role manager --new_mdm_management_ip ${my_ip} --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --query_cluster 2> /dev/null | grep '${my_ip}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif  => "test ! -z '${my_ip}'",
  }

  notify { "scaleio2::mdm::config::cluster::mdm2->end": }
}
