# the installation part
class scaleio2::gateway::install inherits scaleio2::gateway {
  $version                 = $scaleio2::gateway::version
  $pkg                     = $scaleio2::gateway::pkgs['gateway']

  notify { "scaleio2::gateway::install->start": }

  class { 'java':
    distribution  => 'jdk',
    version       =>  'latest',
  }
  package { 'scaleio2::gateway::install':
    name => $pkg,
    ensure   => $version,
    require  => Package[ 'java' ],
  }

  notify { "scaleio2::gateway::install->end": }
}
