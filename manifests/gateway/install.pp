# the installation part
class scaleio2::gateway::install {
  $pkg                     = $scaleio2::gateway::pkg

  include ::java

  notify { "scaleio2::gateway::install->start": }
  class { 'java':
    distribution  => 'jdk',
    version       =>  'latest',
  }
  package { 'scaleio2::gateway::install':
    name => $pkg,
    require  => Package[ 'java', 'numactl', 'libaio' ],
  }

  notify { "scaleio2::gateway::install->end": }
}
