class scaleio2::sds (
  $version                 = $scaleio2::params::version,
  $pkg                     = $scaleio2::params::pkg,
  $sio_sds_network         = $scaleio2::params::sio_sds_network,
  $sds_ssd_env_flag        = $scaleio2::params::sds_ssd_env_flag
) inherits scaleio2::params {

  include ::scaleio2::sds::config
  include ::scaleio2::sds::install
  include ::scaleio2::sds::service

  Class ['::scaleio2::sds::install'] ->
  Class ['::scaleio2::sds::config'] ->
  Class ['::scaleio2::sds::service']
}
