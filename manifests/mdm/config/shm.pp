
class scaleio2::mdm::config::shm {
	$shm_size = $scaleio2::mdm::config::shm_size

	notify { "scaleio2::mdm::config::shm->start": }

	exec { 'scaleio2::mdm::config::shm->mount':
	  command => "mount -o remount -o size=${shm_size} /dev/shm",
	  path => ["/bin","/usr/bin"],
	  onlyif => [ "test `df -B1 /dev/shm | grep shm | awk '{ print \$4; }'` -lt ${shm_size}" ],
	}

#	`cat /etc/fstab | grep "/dev/shm" | awk '{ print $4;}' | awk -F, '{ print $2}' | grep size | awk -F= '{ print $2}'`
	file_line { '/etc/fstab':
	    path => '/etc/fstab',
	    match => "^tmpfs",
	    line => "tmpfs  /dev/shm  tmpfs defaults,size=${shm_size}  0 0",
	}

	exec { 'scaleio2::mdm::config::shm->sysctl':
		command   => 'sysctl -p kernel.shmmax 209715200',
		logoutput => true,
		path => ["/usr/bin", "/sbin", "/bin"],
		onlyif		=> "test $(sysctl kernel.shmmax | cut -d'=' -f2) -ge 209715200",
	}

	notify { "scaleio2::mdm::config::shm->end": }
}
