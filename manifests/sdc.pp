class scaleio2::sdc {
  $version    = $scaleio2::version
  $pkgs       = $scaleio2::pkgs

  include ::scaleio2::sdc::config
  include ::scaleio2::sdc::install
  include ::scaleio2::sdc::service

  Class ['::scaleio2::sdc::install'] ->
  Class ['::scaleio2::sdc::config'] ->
  Class ['::scaleio2::sdc::service']

}
