# PRIVATE CLASS: do not use directly
class scaleio2::repo::apt inherits scaleio2::repo {
  contain apt

  apt::source { 'scaleio2':
    location    => $::scaleio::repo::location,
    release     => 'unstable',
    repos       => 'main contrib',
    key         => '492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10',
    key_server  => 'hkp://keyserver.ubuntu.com:80',
    include_src => false,
  }

  Apt::Source['scaleio']->Package<|tag == 'ScaleIO2'|>
}
