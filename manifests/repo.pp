# PRIVATE CLASS: do not use directly
class scaleio2::repo (
  $ensure        = $scaleio2::params::ensure,
  $version       = $scaleio2::params::version,
  $repo_location = $scaleio2::params::repo_location,
  $description   = undef,
) inherits scaleio2::params {

  contain scaleio2::repo::apt
  contain scaleio2::repo::yum
  contain scaleio2::repo::zypper

  case $::osfamily {
    'RedHat', 'CentOS': {
      if ($repo_location != undef) {
        $location = $repo_location
        $description = 'ScaleIO2 Custom Repository'
      }
      else {
        $location = $::architecture ? {
          'x86_64' => 'https://dl.bintray.com/emccode/scaleio2-rpm/x86_64/',
          'i686'   => 'https://dl.bintray.com/emccode/scaleio2-rpm/i686/',
          'i386'   => 'https://dl.bintray.com/emccode/scaleio2-rpm/i686/',
          default  => undef
        }
        $description = 'ScaleIO2'
      }
      class { '::scaleio2::repo::yum': }
    }

    'Debian', 'Ubuntu': {
      fail("Debian/Ubuntu not ready :(")
    }

    'SUSE', 'OpenSUSE': {
      fail("SUSE/OpenSUSE not ready :(")
    }

    default: {
      if($ensure == 'present' or $ensure == true) {
        fail("Unsupported managed repository for osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports managing repos for osfamily RedHat, Debian and Ubuntu")
      }
    }
  }
}
