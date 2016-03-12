class scaleio2::sdc::install inherits scaleio2::sdc {
  $version   = $scaleio2::sdc::version
  $pkg       = $scaleio2::sdc::pkgs['sdc']

  notify { "scaleio2::sdc::install->start": }
  package { 'scaleio2::sdc::install':
    name    => $pkg,
    ensure  => $version,
  }
  notify { "scaleio2::sdc::install->end": }
}
