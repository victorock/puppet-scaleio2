#
class scaleio2::mdm (
  $cluster_mode     = $scaleio2::params::cluster_mode,
  $cluster_name     = $scaleio2::params::cluster_name,
  $password         = $scaleio2::params::password,
  $tb_ip            = $scaleio2::params::tb_ip,
  $version          = $scaleio2::params::version,
  $mdm_ip           = $scaleio2::params::mdm_ip,
  $sio_sds          = $scaleio2::params::sio_sds,
  $sio_sdc          = $scaleio2::params::sio_sdc,
  $ip_address_array = $scaleio2::params::ip_address_array,
  $is_manager        = 1
) inherits scaleio2::params {

  contain scaleio2::mdm::install
  contain scaleio2::mdm::config
  contain scaleio2::mdm::service

  Class['::scaleio2::mdm::install'] ->
  Class['::scaleio2::mdm::config'] ->
  Class['::scaleio2::mdm::service']

}
