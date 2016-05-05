# PRIVATE CLASS: do not use directly
class scaleio2::repo::yum {
  yumrepo { 'scaleio-repository':
    descr    => $scaleio2::repo::description,
    baseurl  => $scaleio2::repo::location,
    gpgcheck => '0',
    enabled  => '1',
  }
}
