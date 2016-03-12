class scaleio2::lia inherits scaleio2 {
  $version  = $scaleio2::version
  $pkgs     = $scaleio2::pkgs
  
  contain scaleio::lia::install
  contain scaleio::lia::config
  contain scaleio::lia::service

  Class['::scaleio::lia::install'] ->
  Class['::scaleio::lia::config']  ~>
  Class['::scaleio::lia::service']

}
