class scaleio2::lia (
  $pkg  = $scaleio2::params::pkg
) inherits scaleio2::params {

  contain scaleio2::lia::config
  contain scaleio2::lia::install
  contain scaleio2::lia::service

  Class ['::scaleio2::lia::install'] ->
  Class ['::scaleio2::lia::config'] ->
  Class ['::scaleio2::lia::service']

}
