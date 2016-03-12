class scaleio2::gateway::config inherits scaleio2::gateway {
  $mdm_ip   = join($scaleio2::gateway::mdm_ip, ',')
  $password = $scaleio2::gateway::password

  notify { "scaleio2::gateway::config->start": }

  file_line { '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties':
    ensure  => present,
    line    => "mdm.ip.addresses=$mdm_ip",
    path    => '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties',
    match   => '^mdm.ip.addresses=.*',
    notify  => Service['scaleio2::gateway::service'],
  } ->

  exec { 'scaleio2::gateway::config->set_admin_password':
    command => "java -jar /opt/emc/scaleio/gateway/webapps/ROOT/resources/install-CLI.jar --reset_password '${password}' --config_file /opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties",
    path => "/etc/alternatives",
    refreshonly => true,
  }

  notify { "scaleio2::gateway::config->end": }
}
