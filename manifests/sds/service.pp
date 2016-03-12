class scaleio2::sds::service inherits scaleio2::sds {

  notify { "scaleio2::sds::service->start": }
  service { 'scaleio2::sds::service':
    name      => 'sds',
    ensure    => running,
    enable    => true,
    hasrestart => true,
    hasstatus  => true,
  }
  notify { "scaleio2::sds::service->end": }

}
