class scaleio2::mdm::config::cluster::tb2 {

  $my_ip = $scaleio2::mdm::config::cluster::tb_ip[1]

  notify { "scaleio2::mdm::config::cluster::tb2->start": }

  exec { 'scaleio2::mdm::config::cluster::tb2->add_tb2':
    command => "scli --add_standby_mdm --new_mdm_ip ${my_ip} --mdm_role tb --new_mdm_management_ip ${my_ip} --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --query_cluster 2> /dev/null | grep '${my_ip}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif  => "test -n '${my_ip}'",
  } ->

  exec { 'scaleio2::mdm::config::cluster::tb2->switch_to_cluster_mode5':
    command => "scli --switch_cluster_mode --cluster_mode 5_node --i_am_sure",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --query_cluster 2> /dev/null | grep '5_node'",
    onlyif  =>  "test 5 -eq $(scli --query_cluster 2> /dev/null | grep 'Name' | wc -l)",
    require => Class['::scaleio2::mdm::config::login'],
  }

  notify { "scaleio2::mdm::config::cluster::tb2->end": }
}
