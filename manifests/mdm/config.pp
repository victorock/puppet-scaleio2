
class scaleio2::mdm::config {
  $cluster_mode     = $scaleio2::mdm::cluster_mode
  $cluster_name     = $scaleio2::mdm::cluster_name
  $password         = $scaleio2::mdm::password
  $tb_ip            = $scaleio2::mdm::tb_ip
  $version          = $scaleio2::mdm::version
  $mdm_ip           = $scaleio2::mdm::mdm_ip
  $pkg              = $scaleio2::mdm::pkg
  $sio_sds          = $scaleio2::mdm::sio_sds
  $sio_sdc          = $scaleio2::mdm::sio_sdc
  $ip_address_array = $scaleio2::mdm::ip_address_array
  $is_manager       = $scaleio2::mdm::is_manager


  notify { "scaleio2::mdm::config->start": }

  contain scaleio2::mdm::config::role
  Class['::scaleio2::mdm::config::role']

  if ( $mdm_ip[0] in $ip_address_array) {
    contain scaleio2::mdm::config::login
    contain scaleio2::mdm::config::cluster
    contain scaleio2::mdm::config::backend
    contain scaleio2::mdm::config::frontend

    Class['::scaleio2::mdm::config::cluster'] ->
    Class['::scaleio2::mdm::config::backend'] ->
    Class['::scaleio2::mdm::config::frontend']
  }

  notify { "scaleio2::mdm::config->end": }
}
