class scaleio2::gateway (
  $password = $scaleio2::params::password,
  $mdm_ip   = $scaleio2::params::mdm_ip,
  $pkg      = $scaleio2::params::pkg
) inherits scaleio2::params {

  contain scaleio2::gateway::config
  contain scaleio2::gateway::install
  contain scaleio2::gateway::service

  Class ['::scaleio2::gateway::install'] ->
  Class ['::scaleio2::gateway::config'] ->
  Class ['::scaleio2::gateway::service']
}
