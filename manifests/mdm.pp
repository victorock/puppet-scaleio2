class scaleio2::mdm inherits scaleio2 {

  $cluster_mode     = $scaleio2::cluster_mode
  $cluster_name     = $scaleio2::cluster_name
  $password         = $scaleio2::password
  $tb_ip            = $scaleio2::tb_ip
  $version          = $scaleio2::version
  $mdm_ip           = $scaleio2::mdm_ip
  $pkgs             = $scaleio2::pkgs
  $sio_sds          = $scaleio2::sio_sds
  $sio_sdc          = $scaleio2::sio_sdc
  $ip_address_array = $scaleio2::ip_address_array

  contain scaleio2::mdm::install
  contain scaleio2::mdm::config
  contain scaleio2::mdm::service

  Class['::scaleio2::mdm::install'] ->
  Class['::scaleio2::mdm::config']  ~>
  Class['::scaleio2::mdm::service']

}
