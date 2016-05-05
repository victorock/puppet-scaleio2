
class scaleio2::firewall::config::tb inherits scaleio2::firewall::config {

  firewall { '001 Open Port 9011 for ScaleIO Tie-Breaker':
    port   => [9011],
    proto  => tcp,
    action => accept,
  }

}
