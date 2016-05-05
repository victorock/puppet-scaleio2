class scaleio2::mdm::config::login {
  $password = $scaleio2::mdm::config::password
  $mdm_ips  = join($scaleio2::mdm::config::mdm_ip, ',')

  notify { "scaleio2::mdm::login->start": }

  exec { 'scaleio2::mdm::config::login':
    command => "scli --mdm_ip '${mdm_ips}' --login --username admin --password '${password}' --approve_certificate",
    path => ["/usr/bin", "/sbin", "/bin"],
    onlyif => "test -e scli",
    require => Class['::scaleio2::mdm::install'],
  }

  notify { "scaleio2::mdm::login->end": }
}
