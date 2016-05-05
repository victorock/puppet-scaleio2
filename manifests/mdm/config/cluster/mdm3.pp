class scaleio2::mdm::config::cluster::mdm3 {

  $my_ip = $scaleio2::mdm::config::cluster::mdm_ip[2]

  notify { "scaleio2::mdm::config::cluster::mdm3->start": }

  exec { 'scaleio2::mdm::config::cluster::mdm3->add_3th_mdm':
    command => "scli --add_standby_mdm --new_mdm_ip ${my_ip} --mdm_role manager --new_mdm_management_ip ${my_ip} --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --query_cluster 2> /dev/null | grep '${my_ip}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif  => "test -n '${my_ip}'",
  }

  notify { "scaleio2::mdm::config::cluster::mdm3->end": }
}
