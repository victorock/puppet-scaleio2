class scaleio2::mdm::install {
  $pkg            = $scaleio2::mdm::pkg

  notify { "scaleio2::mdm::install->start": } ->
  package { ['mutt', 'python', 'python-paramiko' ]:
    ensure  => present,
  } ->
  package { 'scaleio2::mdm::install':
    name    => $pkg,
    require => Package[ 'numactl', 'libaio' ],
  } ->
  notify { "scaleio2::mdm::install->end": }
}
