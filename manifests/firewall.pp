class scaleio2::firewall {

  contain scaleio2::firewall::config
  contain scaleio2::firewall::install
  contain scaleio2::firewall::service

  Class ['::scaleio2::firewall::install'] ->
  Class ['::scaleio2::firewall::config'] ->
  Class ['::scaleio2::firewall::service']
}
