# PRIVATE CLASS: do not use directly
class scaleio2::repo::yum inherits scaleio2::repo {

  yumrepo { 'scaleio':
    descr    => $::scaleio::repo::description,
    baseurl  => $::scaleio::repo::location,
    gpgcheck => '0',
    enabled  => '1',
  }

}
