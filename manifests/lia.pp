class scaleio2::lia {
  $version  = $scaleio2::version
  $pkgs     = $scaleio2::pkgs

  include ::scaleio2::lia::config
  include ::scaleio2::lia::install
  include ::scaleio2::lia::service

  Class ['::scaleio2::lia::install'] ->
  Class ['::scaleio2::lia::config'] ->
  Class ['::scaleio2::lia::service']

}
