class scaleio2::mdm::install inherits scaleio2::mdm {

  $version    = $scaleio2::mdm::version
  $pkg       = $scaleio2::mdm::pkgs['mdm']

  notify { "scaleio2::mdm::install->start": }

  package { 'scaleio2::mdm::install->deps':
    name    => ['mutt', 'python', 'python-paramiko' ],
    ensure  => present,
  } ->

  package { 'scaleio2::mdm::install':
    name    => $pkg,
    ensure  => $version,
    require => Class[ 'scaleio2::mdm::config::shm' ],
  }

  notify { "scaleio2::mdm::install->end": }
}
