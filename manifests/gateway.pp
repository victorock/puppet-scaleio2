class scaleio2::gateway {

  $cluster_mode            = $scaleio2::cluster_mode
  $cluster_name            = $scaleio2::cluster_name
  $password                = $scaleio2::password
  $tb_ip                   = $scaleio2::tb_ip
  $version                 = $scaleio2::version
  $mdm_ip                  = $scaleio2::mdm_ip
  $pkgs                    = $scaleio2::pkgs

  include ::scaleio2::gateway::config
  include ::scaleio2::gateway::install
  include ::scaleio2::gateway::service

  Class ['::scaleio2::gateway::install'] ->
  Class ['::scaleio2::gateway::config'] ->
  Class ['::scaleio2::gateway::service']
}
