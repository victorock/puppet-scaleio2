class scaleio2::callhome::install inherits scaleio2::callhome {

  $version        = $scaleio2::callhome::version
  $pkg            = $scaleio2::callhome::pkgs['callhome']

  notify { "scaleio2::callhome::install->start": }
  package { 'scaleio2::callhome::install':
    name => $pkg,
    ensure   => $version,
  }
  notify { "scaleio2::callhome::install->end": }

}
