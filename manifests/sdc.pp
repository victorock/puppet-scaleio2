class scaleio2::sdc (
  $mdm_ip     = $scaleio2::params::mdm_ip,
  $pkgs       = $scaleio2::params::pkg
) inherits scaleio2::params {

  contain scaleio2::sdc::config
  contain scaleio2::sdc::install
  contain scaleio2::sdc::service

  Class ['::scaleio2::sdc::install'] ->
  Class ['::scaleio2::sdc::config'] ->
  Class ['::scaleio2::sdc::service']

}
