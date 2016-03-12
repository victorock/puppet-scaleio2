class scaleio2::lia::service inherits scaleio2::lia {
  notify { "scaleio2::lia::service->start": }

  service { 'scaleio2::lia::service':
    name      => 'lia',
    ensure    => running,
    enable    => true,
  }

  notify { "scaleio2::lia::service->end": }
}
