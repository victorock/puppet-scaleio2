class scaleio2::lia::service {
  notify { "scaleio2::lia::service->start": }

  service { 'scaleio2::lia::service':
    name      => 'lia',
    ensure    => running,
    enable    => true,
  }

  notify { "scaleio2::lia::service->end": }
}
