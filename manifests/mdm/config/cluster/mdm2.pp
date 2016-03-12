class scaleio2::mdm::config::cluster::mdm2 inherits scaleio2::mdm::config::cluster {

  $my_ip = $scaleio2::mdm::config::cluster::mdm_ip[1]

  notify { "scaleio2::mdm::config::cluster::mdm2->start": }

  file { '/opt/emc/mdm/cfg/conf.txt':
    path    => '/opt/emc/mdm/cfg/conf.txt',
    ensure  => file,
    owner   => 'root',
    mode    => '0644',
    require => Package['scaleio2::mdm::install'],
    notify  => Service['scaleio2::mdm::service'],
    content => epp('scaleio2/mdm/conf.txt.epp', {'actor_role_is_manager' => '1'}),
  } ->

  exec { 'scaleio2::mdm::config::cluster::mdm2->add_2nd_mdm':
    command => "scli --add_standby_mdm --new_mdm_ip ${my_ip} --mdm_role manager --new_mdm_management_ip ${my_ip}",
    path    => '/bin',
    unless  =>  "scli --query_cluster 2> /dev/null | grep ${my_ip}",
    require => Class['::scaleio2::mdm::login'],
  }

  notify { "scaleio2::mdm::config::cluster::mdm2->end": }
}
