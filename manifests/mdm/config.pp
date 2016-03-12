
class scaleio2::mdm::config inherits scaleio2::mdm {

  $cluster_mode   = $scaleio2::mdm::cluster_mode
  $cluster_name   = $scaleio2::mdm::cluster_name
  $password       = $scaleio2::mdm::password
  $tb_ip          = $scaleio2::mdm::tb_ip
  $version        = $scaleio2::mdm::version
  $mdm_ip         = $scaleio2::mdm::mdm_ip
  $pkgs           = $scaleio2::mdm::pkgs
  $sio_sds        = $scaleio2::mdm::sio_sds
  $sio_sdc        = $scaleio2::mdm::sio_sdc

  contain scaleio2::mdm::config::cluster
  contain scaleio2::mdm::config::backend
  contain scaleio2::mdm::config::frontend
  
  notify { "scaleio2::mdm::config->start": }

  Class['scaleio2::mdm::config::cluster'] ->
  Class['scaleio2::mdm::config::backend'] ->
  Class['scaleio2::mdm::config::frontend']

  notify { "scaleio2::mdm::config->end": }
}
