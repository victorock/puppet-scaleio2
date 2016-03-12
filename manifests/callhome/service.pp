class scaleio2::callhome::service inherits scaleio2::callhome {

notify { "scaleio2::callhome::service->start": }

  service { 'scaleio2::callhome::service::callhome':
    name      => 'callhome',
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/emc/scaleio/callhome/cfg/conf.txt'],
  }

  notify { "scaleio2::callhome::service->start": }
}
