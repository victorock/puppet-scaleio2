
$mdm_ip = [ '192.168.69.150' ]
$tb_ip = [ '192.168.69.150' ]
$password = 'Scaleio123'

$sio_sds = {
  'server01' =>
    {
      protection_domain_name  => 'domain01',
      storage_pool_name       => 'pool01',
      sds_ip                  => '192.168.10.101',
      device_name             => 'disk1',
      device_path             => '/dev/sdb2'
    },
  'server02' =>
    {
      protection_domain_name  => 'domain01',
      storage_pool_name       => 'pool01',
      sds_ip                  => '192.168.10.102',
      device_name             => 'disk1',
      device_path             => '/dev/sdb2'
    },
  'server02' =>
    {
      protection_domain_name  => 'domain01',
      storage_pool_name       => 'pool01',
      sds_ip                  => '192.168.10.102',
      device_name             => 'disk1',
      device_path             => '/dev/sdb2'
    }
  }

$sio_sdc = {
  '192.168.10.101' =>
    {
      protection_domain_name  => 'domain01',
      storage_pool_name       => 'pool01',
      volume_name             => 'vol01',
      volume_type             => 'thin',
      volume_size             => '16'
    },
  '192.168.10.101' =>
    {
      protection_domain_name  => 'domain01',
      storage_pool_name       => 'pool01',
      volume_name             => 'vol02',
      volume_type             => 'thick',
      volume_size             => '16',
      sdc_ip                  => '192.168.10.101'
    },
  '192.168.10.102' =>
    {
      protection_domain_name  => 'domain01',
      storage_pool_name       => 'pool01',
      volume_name             => 'vol01',
      volume_type             => 'thin',
      volume_size             => '16',
      sdc_ip                  => '192.168.10.102'
    }
  }

node /localhost/ {
  class { 'scaleio2':
        password => $password,
        mdm_ip => $mdm_ip,
        tb_ip => $tb_ip,
        sio_sds => $sio_sds,
        sio_sdc => $sio_sdc,
        components => [ 'mdm', 'sds', 'lia' ]
  }
}
