class scaleio2::callhome (
  $version                = $scaleio2::version,
  $pkg                    = $scaleio2::pkg,
  $callhome_cfg           = $scaleio2::callhome_cfg
) inherits params {
  include ::scaleio2::callhome::config
  include ::scaleio2::callhome::install
  include ::scaleio2::callhome::service

  Class ['::scaleio2::callhome::install'] ->
  Class ['::scaleio2::callhome::config'] ->
  Class ['::scaleio2::callhome::service']
}
