class scaleio2::gateway::service inherits scaleio2::gateway {

  notify { "scaleio2::gateway::service->start": }

  service { 'scaleio2::gateway::service':
    name      => 'scaleio-gateway',
    ensure    => running,
    enable    => true,
    subscribe => File['/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties'],
  }

  notify { "scaleio2::gateway::service->end": }
}
