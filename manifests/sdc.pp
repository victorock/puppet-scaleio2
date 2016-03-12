class scaleio2::sdc inherits scaleio2 {
  $version    = $scaleio2::version
  $pkgs       = $scaleio2::pkgs

  contain scaleio2::sdc::install
  contain scaleio2::sdc::config
  contain scaleio2::sdc::service

  Class['::scaleio2::sdc::install'] ->
  Class['::scaleio2::sdc::config']  ~>
  Class['::scaleio2::sdc::service']

}
