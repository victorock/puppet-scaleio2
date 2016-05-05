# the installation part
class scaleio2::sds::install {
  $pkg = $scaleio2::sds::pkg

  notify  { "scaleio2::sds::install->start": } ->
  package { "scaleio2::sds::install":
    name => $pkg,
    require => Package[ 'numactl', 'libaio' ],
  } ->
  notify  { "scaleio2::sds::install->end": }
}
