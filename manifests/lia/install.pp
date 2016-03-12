class scaleio2::lia::install inherits scaleio2::lia {
  $version = $scaleio2::lia::version
  $pkg     = $scaleio2::lia::pkgs['lia']

  notify { "scaleio2::lia::install->start": }
  package { 'scaleio2::lia::install':
    name    => $pkg,
    ensure  => $version,
  }
  notify { "scaleio2::lia::install->end": }
}
