class scaleio2::sdc::install {
  $pkg       = $scaleio2::sdc::pkg

  notify { "scaleio2::sdc::install->start": } ->
  package { 'scaleio2::sdc::install':
    name    => $pkg,
    require => Package[ 'numactl', 'libaio' ],
  } ->
  notify { "scaleio2::sdc::install->end": }
}
