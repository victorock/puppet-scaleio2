class scaleio2::mdm::login {

  $password = $scaleio2::password
  $mdm_ips  = join($scaleio2::mdm_ip, ',')

  notify { "scaleio2::mdm::login->start": }

  exec { 'scaleio2::mdm::login':
    command => "scli --mdm_ip '${mdm_ips}' --login --username admin --password '${password}'",
    path    => '/bin',
    unless => '/usr/bin/test ! -e /bin/scli',
  }

  notify { "scaleio2::mdm::login->end": }
}
