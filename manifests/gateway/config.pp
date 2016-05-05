class scaleio2::gateway::config inherits scaleio2::gateway {
  $mdm_ip   = join($scaleio2::gateway::mdm_ip, ',')
  $password = $scaleio2::gateway::password

  notify { "scaleio2::gateway::config->start": }

  file { '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties':
    path      => '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties',
    ensure    => present,
    require => [ Class['::scaleio2::mdm::login'], Class['::scaleio2::mdm::install'] ],
  } ->
  file_line { "scaleio::gateway::config->mdm.ipaddresses":
    ensure  => present,
    line    => "mdm.ip.addresses=$mdm_ip",
    path    => '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties',
    match   => '^mdm.ip.addresses=.*',
    notify  => Service['scaleio2::gateway::service'],
    require => [ Class['::scaleio2::mdm::login'], Class['::scaleio2::mdm::install'] ],
  } ->

  file_line { "scaleio::gateway::config->allow_non_secure_communication":
    ensure  => present,
    line    => "gateway-security.allow_non_secure_communication=true",
    path    => '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties',
    match   => '^gateway-security.allow_non_secure_communication=.*',
    notify  => Service['scaleio2::gateway::service'],
    require => [ Class['::scaleio2::mdm::login'], Class['::scaleio2::mdm::install'] ],
  } ->

  file_line { "scaleio::gateway::config->bypass_certificate_check":
    ensure  => present,
    line    => "security.bypass_certificate_check=true",
    path    => '/opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties',
    match   => '^security.bypass_certificate_check=.*',
    notify  => Service['scaleio2::gateway::service'],
    require => [ Class['::scaleio2::mdm::login'], Class['::scaleio2::mdm::install'] ],
  } ->

  exec { 'scaleio2::gateway::config->set_admin_password':
    command => "java -jar /opt/emc/scaleio/gateway/webapps/ROOT/resources/install-CLI.jar --reset_password '${password}' --config_file /opt/emc/scaleio/gateway/webapps/ROOT/WEB-INF/classes/gatewayUser.properties",
    path => "/etc/alternatives",
    refreshonly => true,
    require => [ Class['::scaleio2::mdm::login'], Class['::scaleio2::mdm::install'] ],
  }

  notify { "scaleio2::gateway::config->end": }
}
