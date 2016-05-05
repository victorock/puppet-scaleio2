class scaleio2::mdm::config::cluster::mdm1 {

  $my_ip       = $scaleio2::mdm::mdm_ip[0]
  $my_password = $scaleio2::mdm::password

  notify { "scaleio2::mdm::config::cluster::mdm1->start": }

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster':
    command => "scli --create_mdm_cluster --master_mdm_ip ${my_ip} --master_mdm_management_ip ${my_ip} --accept_license --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --login --username admin --password ${my_password} --approve_certificate",
    onlyif  => "test ! -z '${my_ip}'",
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster->1st_login':
    command => "scli --login --username admin --password admin",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --login --username admin --password ${my_password} --approve_certificate",
    onlyif  => "sleep 5",
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster->1st_login->set_1st_password':
    command => "scli --set_password --old_password admin --new_password ${my_password} --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --login --username admin --password ${my_password} --approve_certificate",
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster->1st_login->set_1st_password->1st_login_new_password':
    command => "scli --mdm_ip ${my_ip} --login --username admin --password ${my_password} --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  =>  "scli --login --username admin --password ${my_password} --approve_certificate",
  }

  notify { "scaleio2::mdm::config::cluster::mdm1->end": }
}
