class scaleio2::params {

  $cluster_name         = "cluster1"
  $components           = undef
  $callhome_cfg         = undef
  $cluster_mode         = "3node"
  $ensure               = true
  $mdm_ip               = undef
  $password             = "Scaleio123"
  $tb_ip                = undef
  $repo_location        = undef
  $shm_size             = 536866816
  $sio_sds_network      = undef
  $sio_sds              = undef
  $sio_sdc              = undef
  $sds_ssd_env_flag     = false
  $version              = '2.0-630'

  ## Facter variables
  ## compliance with strict mode
  if !defined('$ip_address_array')     { $ip_address_array      = undef }
  if !defined('$scaleio_secondary_ip') { $scaleio_secondary_ip  = undef }
  if !defined('$scaleio_primary_ip')   { $scaleio_primary_ip    = undef }
  if !defined('$scaleio_tb_ip')        { $scaleio_tb_ip         = undef }
  if !defined('$scaleio_mdm_state')    { $scaleio_mdm_state     = undef }

  case $::osfamily {
    # Platform Specific variables
    'RedHat', 'SUSE', 'CentOS' : {
      $use_ssd      = false
      $pkgs         = { callhome => "EMC-ScaleIO-callhome",
                        mdm      => "EMC-ScaleIO-mdm",
                        lia      => "EMC-ScaleIO-lia",
                        sds      => "EMC-ScaleIO-sds",
                        sds1     => "EMC-ScaleIO-sds1",
                        sds2     => "EMC-ScaleIO-sds2",
                        sds3     => "EMC-ScaleIO-sds3",
                        sds4     => "EMC-ScaleIO-sds4",
                        sdc      => "EMC-ScaleIO-sdc",
                        gateway  => "EMC-ScaleIO-gateway",
                        gui      => "EMC-ScaleIO-gui"
                      }
    }
    'debian', 'ubuntu' : {
      $use_ssd      = false

      $pkgs         = { callhome => "EMC-ScaleIO-callhome",
                        mdm      => "EMC-ScaleIO-mdm",
                        lia      => "EMC-ScaleIO-lia",
                        sds      => "EMC-ScaleIO-sds",
                        sds1     => "EMC-ScaleIO-sds1",
                        sds2     => "EMC-ScaleIO-sds2",
                        sds3     => "EMC-ScaleIO-sds3",
                        sds4     => "EMC-ScaleIO-sds4",
                        sdc      => "EMC-ScaleIO-sdc",
                        gateway  => "EMC-ScaleIO-gateway",
                        gui      => "EMC-ScaleIO-gui"
                      }
    }
    default: {
      fail("ScaleIO installation is not supported on an ${::osfamily} based system.")
    }
  }
}
