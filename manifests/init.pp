
class scaleio2 (

  $cluster_name         = $scaleio2::params::cluster_name,
  $cluster_mode         = $scaleio2::params::cluster_mode,
  $components           = $scaleio2::params::components,
  $callhome_cfg         = $scaleio2::params::callhome_cfg,
  $mdm_ip               = $scaleio2::params::mdm_ip,
  $password             = $scaleio2::params::password,
  $pkgs                 = $scaleio2::params::pkgs,
  $repo_location        = $scaleio2::params::repo_location,
  $shm_size             = $scaleio2::params::shm_size,
  $sio_sds_network      = $scaleio2::params::sio_sds_network,
  $sio_sds              = $scaleio2::params::sio_sds,
  $sio_sdc              = $scaleio2::params::sio_sdc,
  $sds_ssd_env_flag     = $scaleio2::params::sds_ssd_env_flag,
  $tb_ip                = $scaleio2::params::tb_ip,
  $use_ssd              = $scaleio2::params::use_ssd,
  $version              = $scaleio2::params::version,

  ) inherits scaleio2::params {

# Libraries
  contain stdlib
  contain java
  contain firewall
  contain scaleio2::repo
  contain scaleio2::install
  contain scaleio2::lia
  contain scaleio2::mdm
  contain scaleio2::callhome
  contain scaleio2::gateway
  contain scaleio2::sds
  contain scaleio2::sdc
  contain scaleio2::firewall

# Mandatory Parameters
  validate_array($components)
  validate_array($mdm_ip)
  validate_string($tb_ip)

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

  class{'::scaleio2::repo':}     ->
  class{'::scaleio2::install':}

  if ( 'lia'       in $components ) { class{'scaleio2::lia':}         }
  if ( 'mdm'       in $components ) { class{'::scaleio2::mdm':}       }
  if ( 'callhome'  in $components ) { class{'::scaleio2::callhome':}  }
  if ( 'gateway'   in $components ) { class{'::scaleio2::gateway':}   }
  if ( 'sds'       in $components ) { class{'::scaleio2::sds':}       }
  if ( 'sdc'       in $components ) { class{'::scaleio2::sdc':}       }
  if ( 'firewall'  in $components ) { class{'::scaleio2::firewall':}  }

}
