class scaleio2::callhome (
  $pkg                    = $scaleio2::params::pkg,
  $callhome_cfg           = $scaleio2::params::callhome_cfg
) inherits scaleio2::params {
  contain ::scaleio2::callhome::config
  contain ::scaleio2::callhome::install
  contain ::scaleio2::callhome::service

  Class ['::scaleio2::callhome::install'] ->
  Class ['::scaleio2::callhome::config'] ->
  Class ['::scaleio2::callhome::service']
}
