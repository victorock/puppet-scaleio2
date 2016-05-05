class scaleio2::callhome::install {
  $pkg            = $scaleio2::callhome::pkg

  notify { "scaleio2::callhome::install->start": }
  package { 'scaleio2::callhome::install':
    name => $pkg,
    require => Package[ 'numactl', 'libaio' ],
  }
  notify { "scaleio2::callhome::install->end": }

}
