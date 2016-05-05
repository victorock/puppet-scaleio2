class scaleio2::firewall {

  include ::scaleio2::firewall::config
  include ::scaleio2::firewall::install
  include ::scaleio2::firewall::service

  Class ['::scaleio2::firewall::install'] ->
  Class ['::scaleio2::firewall::config'] ->
  Class ['::scaleio2::firewall::service']
}
