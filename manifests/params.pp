class scaleio2::params {

  $cluster_name         = "cluster1"
  $components           = undef
  $cluster_mode         = "3node"
  $ensure               = true
  $install_repo         = true
  $mdm_ip               = []
  $password             = "Scaleio123"
  $tb_ip                = []
  $repo_location        = "https://dl.bintray.com/victorock/scaleio/centos/\$releasever/x86_64/"
  $repo_description     = undef
  $shm_size             = 536866816
  $sio_sds_network      = undef
  $sio_sds              = undef
  $sio_sdc              = undef
  $sds_ssd_env_flag     = false
  $version              = '2.0-5014.0.el7'

  $callhome_cfg = {
    email_to => "support@acme.com",
    email_from => "scaleio@acme.com",
    username => "username",
    password => "password",
    smtp_host => "10.10.10.10",
    smtp_port => "25",
    smtp_user => "username",
    smtp_password => "password",
    severity => "error",
  }

  ## Facter variables
  ## compliance with strict mode
  if !defined('$ip_address_array')     { $ip_address_array      = undef }
  if !defined('$scaleio_secondary_ip') { $scaleio_secondary_ip  = undef }
  if !defined('$scaleio_primary_ip')   { $scaleio_primary_ip    = undef }
  if !defined('$scaleio_tb_ip')        { $scaleio_tb_ip         = undef }
  if !defined('$scaleio_mdm_state')    { $scaleio_mdm_state     = undef }

  $use_ssd  = false
  $pkg      = { callhome => "EMC-ScaleIO-callhome",
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
