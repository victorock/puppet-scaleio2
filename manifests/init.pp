
class scaleio2 (

  $cluster_name         = $scaleio2::params::cluster_name,
  $cluster_mode         = $scaleio2::params::cluster_mode,
  $components           = $scaleio2::params::components,
  $callhome_cfg         = $scaleio2::params::callhome_cfg,
  $mdm_ip               = $scaleio2::params::mdm_ip,
  $password             = $scaleio2::params::password,
  $pkg                  = $scaleio2::params::pkg,
  $repo_location        = $scaleio2::params::repo_location,
  $shm_size             = $scaleio2::params::shm_size,
  $sio_sds_network      = $scaleio2::params::sio_sds_network,
  $sio_sds              = $scaleio2::params::sio_sds,
  $sio_sdc              = $scaleio2::params::sio_sdc,
  $sds_ssd_env_flag     = $scaleio2::params::sds_ssd_env_flag,
  $tb_ip                = $scaleio2::params::tb_ip,
  $use_ssd              = $scaleio2::params::use_ssd,
  $version              = $scaleio2::params::version,
  $install_repo         = $scaleio2::params::install_repo

  ) inherits scaleio2::params {

# Mandatory Parameters
  validate_array($components)
  validate_array($mdm_ip)
  validate_array($tb_ip)

# Need to define cluster name if cluster is enabled
  if $cluster_mode {
    validate_string($cluster_mode)
    validate_string($cluster_name)
  }

# The rest of parameters are optional
  if $callhome_cfg      { validate_hash($callhome_cfg)      }
  if $password          { validate_string($password)        }
  if $pkgs              { validate_hash($pkgs)              }
  if $repo_location     { validate_string($repo_location)   }
  if $shm_size          { validate_integer($shm_size)       }
  if $sio_sds_network   { validate_string($sio_sds_network) }
  if $sio_sdc           { validate_hash($sio_sdc)           }
  if $sio_sds           { validate_hash($sio_sds)           }
  if $sds_ssd_env_flag  { validate_bool($sds_ssd_env_flag)  }
  if $use_ssd           { validate_bool($use_ssd)           }
  if $version           { validate_string($version)         }
  if $install_repo      { validate_bool($install_repo)      }

  if ($install_repo) {
    class { '::scaleio2::repo': }
  }

  class { '::scaleio2::install': }

  if ( 'lia'       in $components ) {
    class { '::scaleio2::lia':
      pkg => $pkg['lia']
    }
  }

  if ( 'mdm'       in $components ) {
    class { '::scaleio2::mdm':
      pkg              => $pkg['mdm'],
      cluster_mode     => $cluster_mode,
      cluster_name     => $cluster_name,
      password         => $password,
      tb_ip            => $tb_ip,
      mdm_ip           => $mdm_ip,
      sio_sds          => $sio_sds,
      sio_sdc          => $sio_sdc,
      ip_address_array => $ip_address_array,
      is_manager       => 1,
    }
  }
  elsif ( 'tb'       in $components ) {
    class { '::scaleio2::mdm':
      pkg              => $pkg['mdm'],
      cluster_mode     => $cluster_mode,
      cluster_name     => $cluster_name,
      password         => $password,
      tb_ip            => $tb_ip,
      mdm_ip           => $mdm_ip,
      sio_sds          => $sio_sds,
      sio_sdc          => $sio_sdc,
      ip_address_array => $ip_address_array,
      is_manager       => 0,
    }
  }

  if ( 'callhome'  in $components ) {
    class { '::scaleio2::callhome':
      pkg          => $pkg['callhome'],
      callhome_cfg => $callhome_cfg
    }
  }

  if ( 'gateway'   in $components ) {
    class { '::scaleio2::gateway':
      pkg       => $pkg['gateway'],
      password  => $password,
      mdm_ip    => $mdm_ip
    }
  }

  if ( 'sds'       in $components ) {
    class { '::scaleio2::sds':
      pkg               => $pkg['sds'],
      sio_sds_network   => $sio_sds_network,
      sds_ssd_env_flag  => $sds_ssd_env_flag
    }
  }

  if ( 'sdc'       in $components ) {
    class { '::scaleio2::sdc':
      pkg     => $pkg['sdc'],
      mdm_ip  => $mdm_ip
    }
  }

#  if ( 'firewall'  in $components ) {
#    class { '::scaleio2::firewall':
#      pkg => $pkg
#    }
#  }

}
