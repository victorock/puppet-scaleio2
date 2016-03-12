
class scaleio2::backend::mdm::config::shm {
	$shm_size = $scaleio2::shm_size

	notify { "scaleio2::backend::mdm::config::shm->start": }

	exec { 'scaleio2::backend::mdm::config::shm->mount':
	  command => "mount -o remount -o size=${shm_size} /dev/shm",
	  path => ["/bin","/usr/bin"],
	  onlyif => [ "test `df -B1 /dev/shm | awk '/\/dev\/shm/ { print \$4; }'` -lt ${shm_size}" ],
	}

#	`cat /etc/fstab | grep "/dev/shm" | awk '{ print $4;}' | awk -F, '{ print $2}' | grep size | awk -F= '{ print $2}'`
	file_line { '/etc/fstab':
	    path => '/etc/fstab',
	    match => "^tmpfs",
	    line => "tmpfs  /dev/shm  tmpfs defaults,size=${shm_size}  0 0",
	}

	if ($::kernelshmmax.scanf("%i")[0] < 209715200) {
    exec { 'scaleio2::backend::mdm::config::shm':
      command   => 'sysctl -p 209715200',
      logoutput => true,
      path      => '/sbin',
    }
  }

	notify { "scaleio2::backend::mdm::config::shm->end": }
}
