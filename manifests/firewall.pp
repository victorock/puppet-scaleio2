
class scaleio2::firewall inherits scaleio2 {
  contain scaleio::firewall::install
  contain scaleio::firewall::config
  contain scaleio::firewall::service

  Class['::scaleio::firewall::install'] ->
  Class['::scaleio::firewall::config']  ~>
  Class['::scaleio::firewall::service']
}
