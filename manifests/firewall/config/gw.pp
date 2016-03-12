
class scaleio::firewall::gw {

  firewall { '001 for ScaleIO Gateway':
    port   => [443],
    proto  => tcp,
    action => accept,
  }

}
