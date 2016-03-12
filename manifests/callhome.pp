class scaleio2::callhome inherits scaleio2 {
  $version                 = $scaleio2::version
  $pkgs                    = $scaleio2::pkgs
  $callhome_cfg            = $scaleio2::callhome_cfg

  contain scaleio2::callhome::install
  contain scaleio2::callhome::config
  contain scaleio2::callhome::service

  Class['::scaleio2::callhome::install'] ->
  Class['::scaleio2::callhome::config']  ~>
  Class['::scaleio2::callhome::service']
}
