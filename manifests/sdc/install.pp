class scaleio2::sdc::install (
  $version   = $scaleio2::params::version,
  $pkg       = $scaleio2::params::pkg['sdc']
) inherits scaleio2::sdc {

  notify { "scaleio2::sdc::install->start": }
  package { 'scaleio2::sdc::install':
    name    => $pkg,
    ensure  => $version,
  }
  notify { "scaleio2::sdc::install->end": }
}
