class scaleio2::mdm::config::cluster inherits scaleio2::mdm {
  $cluster_mode     = $scaleio2::mdm::cluster_mode
  $cluster_name     = $scaleio2::mdm::cluster_name
  $password         = $scaleio2::mdm::password
  $tb_ip            = $scaleio2::mdm::tb_ip
  $mdm_ip           = $scaleio2::mdm::mdm_ip
  $ip_address_array = $scaleio2::mdm::ip_address_array

  contain scaleio2::mdm::config::cluster::mdm1
  contain scaleio2::mdm::config::cluster::mdm2
  contain scaleio2::mdm::config::cluster::mdm3
  contain scaleio2::mdm::config::cluster::tb1
  contain scaleio2::mdm::config::cluster::tb2
  
  notify { "scaleio2::mdm::config::cluster->start": }

  if    ( $mdm_ip[0]  in $ip_address_array )  { class{'scaleio2::mdm::config::cluster::mdm1':}  }
  elsif ( $mdm_ip[1]  in $ip_address_array )  { class{'scaleio2::mdm::config::cluster::mdm2':}  }
  elsif ( $mdm_ip[2]  in $ip_address_array )  { class{'scaleio2::mdm::config::cluster::mdm3':}  }
  elsif ( $tb_ip[0]   in $ip_address_array )  { class{'scaleio2::mdm::config::cluster::tb1':}   }
  elsif ( $tb_ip[1]   in $ip_address_array )  { class{'scaleio2::mdm::config::cluster::tb2':}   }
  
  exec { 'scaleio2::mdm::config::cluster->switch_to_cluster_mode':
    command => "scli --switch_cluster_mode --cluster_mode '${cluster_mode}'",
    path    => '/bin',
    unless  =>  "scli --query_cluster 2> /dev/null | grep '${cluster_mode}'",
    require => Class['::scaleio2::mdm::login'],
  }

  exec { 'scaleio2::mdm::config::cluster->rename':
    command => "scli --rename_system --new_name '${cluster_name}'",
    path    => '/bin',
    unless  => "scli --query_cluster 2> /dev/null | grep 'Name: ${cluster_name}'",
    require => Class['::scaleio2::mdm::login'],
  }

  notify { "scaleio2::mdm::config::cluster->end": }
}
