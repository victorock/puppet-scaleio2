class scaleio2::lia::install {
  $pkg     = $scaleio2::lia::pkg

  notify { "scaleio2::lia::install->start": }
  package { 'scaleio2::lia::install':
    name    => $pkg,
    require => Package[ 'numactl', 'libaio' ],
  }
  notify { "scaleio2::lia::install->end": }
}
