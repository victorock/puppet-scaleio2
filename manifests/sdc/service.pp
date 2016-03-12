class scaleio2::sdc::service inherits scaleio2::sdc {
  notify { "scaleio2::sdc::service->start": }
  exec { "scaleio2::sdc::service":
    command =>  "drv_cfg --load_cfg_file",
    path    =>  '/bin/emc/scaleio',
    refreshonly => true,
  }
  notify { "scaleio2::sdc::service->start": }
}
