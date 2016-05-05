
class scaleio2::firewall::config::lia inherits scaleio2::firewall::config {

  firewall { '001 Open Port 9099 for ScaleIO LIA':
    port   => [9099],
    proto  => tcp,
    action => accept,
  }

}
