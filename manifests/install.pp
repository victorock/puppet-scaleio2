class scaleio2::install inherits scaleio2 {
  notify { "scaleio2::install->start": }
  package { [ 'numactl', 'libaio' ] :
    ensure => present,
  }
  notify { "scaleio2::install->end": }
}
