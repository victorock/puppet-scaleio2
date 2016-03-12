class scaleio2::mdm::config::cluster::mdm1 inherits scaleio2::mdm::config::cluster {

  $my_ip       = $scaleio2::mdm::config::cluster::mdm_ip[1]
  $my_password = $scaleio2::mdm::config::cluster::password

  notify { "scaleio2::mdm::config::cluster::mdm1->start": }

  file { '/opt/emc/mdm/cfg/conf.txt':
    path    => '/opt/emc/mdm/cfg/conf.txt',
    ensure  => file,
    owner   => 'root',
    mode    => '0644',
    require => Package['scaleio2::mdm::install'],
    notify  => Service['scaleio2::mdm::service'],
    content => epp('scaleio2/mdm/conf.txt.epp', {'actor_role_is_manager' => '1'}),
  }

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster':
    command => "scli --create_mdm_cluster --master_mdm_ip '${my_ip}' --master_mdm_management_ip '${my_ip}' --accept_license",
    path    => '/bin',
    onlyif  =>  "scli --login --username admin --password admin",
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster->1st_login':
    command => "scli --mdm_ip '${my_ip}' --login --username admin --password admin",
    path    => '/bin',
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster->1st_login->set_1st_password':
    command => "scli --mdm_ip '${my_ip}' --set_password --old_password admin --new_password '${my_password}'",
    path    => '/bin',
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm1->create_cluster->1st_login->set_1st_password->1st_login_new_password':
    command => "scli --mdm_ip '${my_ip}' --login --username admin --password '${my_password}'",
    path    => '/bin',
  }

  notify { "scaleio2::mdm::config::cluster::mdm1->end": }
}
