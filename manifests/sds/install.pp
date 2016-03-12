# the installation part
class scaleio2::sds::install inherits scaleio2::sds {
  $version   = $scaleio2::sds::version
  $pkg       = $scaleio2::sds::pkgs['sds']

  notify { "scaleio2::sds::install->start": }

  package { $pkg:
    ensure   => $version,
  }

  notify { "scaleio2::sds::install->end": }
}
