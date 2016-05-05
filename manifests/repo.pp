#
class scaleio2::repo (
  $ensure             = $scaleio2::params::ensure,
  $repo_location      = $scaleio2::params::repo_location,
  $repo_description   = $scaleio2::params::repo_description
  ) inherits scaleio2::params {

  case $::osfamily {
    'RedHat', 'CentOS': {
      if ($repo_location != undef) {
        $location = $repo_location
        $description = 'ScaleIO2 Custom Repository'
      }
      else {
        $location = "https://dl.bintray.com/victorock/scaleio/centos/\$releasever/x86_64/"
        $description = 'bintray-victorock-scaleio'
      }

      class { '::scaleio2::repo::yum': }

    }

    'Debian', 'Ubuntu': {
      fail("Debian/Ubuntu not ready :(")

      class { '::scaleio2::repo::apt': }
    }

    'SUSE', 'OpenSUSE': {
      fail("SUSE/OpenSUSE not ready :(")

      class { '::scaleio2::repo::zypper': }
    }

    default: {
      if($ensure == 'present' or $ensure == true) {
        fail("Unsupported managed repository for osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports managing repos for osfamily RedHat, Debian and Ubuntu")
      }
    }
  }
}
