class scaleio2::install {
  notify { "scaleio2::install->start": } ->
  package { [ 'numactl', 'libaio' ] :
    ensure => present,
  } ->
  notify { "scaleio2::install->end": }
}
