class scaleio2::mdm::install {
  notify { "scaleio2::mdm::install->start": }
  package { ['mutt', 'python', 'python-paramiko' ]:
    ensure  => present,
  } ->
  package { 'scaleio2::mdm::install':
    name    => "EMC-ScaleIO-mdm",
  }
  notify { "scaleio2::mdm::install->end": }
}
