class scaleio2::sds inherits scaleio2 {
  $version                 = $scaleio2::version
  $pkgs                    = $scaleio2::pkgs
  $sio_sds_network         = $scaleio2::sio_sds_network
  $sds_ssd_env_flag        = $scaleio2::sds_ssd_env_flag

  contain scaleio2::sds::install
  contain scaleio2::sds::config
  contain scaleio2::sds::service

  Class['::scaleio2::sds::install'] ->
  Class['::scaleio2::sds::config']  ~>
  Class['::scaleio2::sds::service']

}
