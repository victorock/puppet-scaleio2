class scaleio2::mdm::config::role {
  $is_manager     = $scaleio2::mdm::config::is_manager

  notify { "scaleio2::mdm::config::role->start": } ->
  file { '/opt/emc/mdm/cfg/conf.txt':
    path    => '/opt/emc/scaleio/mdm/cfg/conf.txt',
    ensure  => file,
    owner   => 'root',
    mode    => '0644',
    notify  => Service['::scaleio2::mdm::service'],
    content => epp('scaleio2/mdm/conf.txt.epp', {'actor_role_is_manager' => "$is_manager" }),
  } ->
  notify { "scaleio2::mdm::config::role->end": }
}
