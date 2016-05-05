# PRIVATE CLASS: do not use directly
class scaleio2::repo::yum {
  $description  = $scaleio2::repo::description
  $location     = $scaleio2::repo::location

  yumrepo { 'scaleio-repository':
    descr    => $description,
    baseurl  => $location,
    gpgcheck => '0',
    enabled  => '1',
  }
}
