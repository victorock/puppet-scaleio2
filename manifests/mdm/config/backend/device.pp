class scaleio2::mdm::config::backend::device {
  $storage_pool_name  = $scaleio2::mdm::config::backend::storage_pool_name
  $sds_name           = $scaleio2::mdm::config::backend::sds_name
  $sds_ip             = $scaleio2::mdm::config::backend::sds_ip
  $device_name        = $scaleio2::mdm::config::backend::device_name
  $device_path        = $scaleio2::mdm::config::backend::device_path

  notify { "scaleio2::mdm::config::backend::device->start": }

  exec { "scaleio2::mdm::config::backend::device->add: ${sds_name},${sds_ip},${storage_pool_name},${device_name},${device_path}":
    command => "scli --add_sds_device --sds_ip '${sds_ip}' --storage_pool_name '${storage_pool_name}' --device_name  '${device_name}' --device_path '${device_path}' --i_am_sure",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  => "scli --query_sds --sds_ip '${sds_ip}' 2>&1 | grep ' Path: ${device_path}'",
    require => Class['::scaleio2::mdm::config::login'],
    onlyif => "test ! -z '${sds_ip}'",
  }

  notify { "scaleio2::mdm::config::backend::device->end": }
}
