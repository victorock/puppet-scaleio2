class scaleio2::firewall::service inherits scaleio2::firewall {
  notify { "scaleio2::firewall::service->start": }

  notify { "scaleio2::firewall::service->end": }
}
