
class scaleio2::firewall::config::gw inherits scaleio2::firewall::config {

  firewall { '001 for ScaleIO Gateway':
    port   => [443],
    proto  => tcp,
    action => accept,
  }

}
