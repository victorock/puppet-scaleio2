class scaleio2::mdm::config::cluster {
  $cluster_name     = $scaleio2::mdm::config::cluster_name
  $password         = $scaleio2::mdm::config::password
  $tb_ip            = $scaleio2::mdm::config::tb_ip
  $mdm_ip           = $scaleio2::mdm::config::mdm_ip
  $ip_address_array = $scaleio2::mdm::config::ip_address_array

  contain scaleio2::mdm::config::cluster::mdm1
  contain scaleio2::mdm::config::cluster::mdm2
  contain scaleio2::mdm::config::cluster::mdm3
  contain scaleio2::mdm::config::cluster::tb1
  contain scaleio2::mdm::config::cluster::tb2
  contain scaleio2::mdm::config::cluster::rename

  notify { "scaleio2::mdm::config::cluster->start": }
  Class['::scaleio2::mdm::config::cluster::mdm1'] ->
  Class['::scaleio2::mdm::config::cluster::mdm2'] ->
  Class['::scaleio2::mdm::config::cluster::mdm3']

  Class['::scaleio2::mdm::config::cluster::tb1'] ->
  Class['::scaleio2::mdm::config::cluster::tb2']

  Class['::scaleio2::mdm::config::cluster::rename']

  notify { "scaleio2::mdm::config::cluster->end": }
}
