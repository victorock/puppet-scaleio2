# ScaleIO2

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What ScaleIO affects](#what-scaleio-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with scaleio](#beginning-with-scaleio)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

A Puppet module that installs and configures the ScaleIO v2 block storage service components.
The module currently supports Redhat/CentOS v7.x.  

See <http://github.com/emccode/puppet-scaleio2/tests/> for a simple working example.

## Module Description

ScaleIO is software that takes local storage from operating systems and configures them in a virtual SAN to deliver block services to operating systems via IP.  The module handles the configuration of ScaleIO components and the creation and mapping of volumes to hosts.

Most aspects of configuration of ScaleIO have been brought into Puppet.  This means an operations team can easily adopt a software storage platform into their existing operations.

## Setup

### What Puppet-ScaleIO affects

* Installs firewall (iptables) settings based on ScaleIO components installed
* Tested with Puppet 3.7.2+
	* puppet.conf [main] - parser = “future”
    * NOTE: This options bugs with foreman.
* Tested with ScaleIO 2.0

### Setup Requirements

* Requires ScaleIO RPMs available through yum/zypper/apt

  - EMC-ScaleIO-callhome.x86_64
  - EMC-ScaleIO-lia.x86_64
  - EMC-ScaleIO-mdm.x86_64
  - EMC-ScaleIO-sdc.x86_64
  - EMC-ScaleIO-sds.x86_64
  - EMC-ScaleIO-sds1.x86_64
  - EMC-ScaleIO-sds2.x86_64
  - EMC-ScaleIO-sds3.x86_64
  - EMC-ScaleIO-sds4.x86_64
  - EMC-ScaleIO-gateway.noarch
  - EMC-ScaleIO-gui.noarch
  - Oracle JDK 8


Required modules to install

	puppet module install puppetlabs-stdlib
	puppet module install puppetlabs-firewall
	puppet module install puppetlabs-java
  puppet module install puppetlabs-apt

Optional module to install

	puppet module install dalen-dnsquery

### Beginning with scaleio

	puppet module install emccode-scaleio2

## Usage

The following section represents variables that are configured at the top of the site.pp file.  They can be considered optional and global as they are reused in the specific class declarations later on.

In order to make the site.pp more dynamic, we are using the hosts_lookup function to retrieve names for DNS names.  This allows a more dynamic capability for IP addresses.  The FQDN's represented below are not used in the Puppet parameters, only as lookup references here in the site.pp file.  If lookups are to occur against a DNS server, the dns_lookup function can be used instead of hosts_lookup.  See the puppet <a href="https://github.com/emccode/puppet-scaleio2/tests/">puppet-scaleio2/tests</a> repo for the most static example of the module.

	$version = '2.0'
	$mdm_ip = [ hosts_lookup('mdm1.scaleio.local')[0],
              hosts_lookup('mdm2.scaleio.local')[0]
            ]
	$tb_ip = hosts_lookup('tb.scaleio.local')[0]
	$cluster_name = "cluster1"
	$cluster_mode = 3node
	$password = 'Scaleio123'

Here we have the sio_sds array that holds the configuration parameters necessary to specify which device or file on the OS will be consumed by ScaleIO.

	$sio_sds = [ "protection_domain_name, storage_pool_name, sds_name, sds_ip, device_name, device_path",
               "protection_domain_name, storage_pool_name, sds_name, sds_ip, device_name, device_path",
              ... ]

Example:
  $sio_sds =  [ "domain01,pool01,server01,192.168.10.101,disk1,/dev/sdb",
                "domain01,pool01,server02,192.168.10.102,disk1,/dev/sdb",
                "domain01,pool01,server03,192.168.10.103,disk1,/dev/sdb"
              ]

The sio_sdc array manage the front-end manipulation, to create and map volumes to specific clients.

	$sio_sdc = [ "protection_domain_name,storage_pool_name,volume_name,volume_type,volume_size,sdc_ip",
               "protection_domain_name,storage_pool_name,volume_name,volume_type,volume_size,sdc_ip",
               "protection_domain_name,storage_pool_name,volume_name,volume_type,volume_size,sdc_ip",
               ...
             ]
 Example:
  $sio_sdc = [  "domain01,pool01,myvol01,thin,16,192.168.10.101",
                "domain01,pool01,myvol01,thin,16,192.168.10.102",
                "domain01,pool01,myvol01,thin,16,192.168.10.103",
                "domain01,pool01,myvol02,thick,16,192.168.10.101",
                "domain01,pool01,myvol02,thick,16,192.168.10.102",
                "domain01,pool01,myvol02,thick,16,192.168.10.103"
              ]

The callhome_cfg section is used to configure callhome services for support.

	$callhome_cfg = {
	        'email_to' => "emailto@address.com",
	        'email_from' => "emailfrom@address.com",
	        'username' => "monitor_username",
	        'password' => "monitor_password",
	        'customer' => "customer_name",
	        'smtp_host' => "smtp_host",
	        'smtp_port' => "smtp_port",
	        'smtp_user' => "smtp_user",
	        'smtp_password' => "smtp_password",
	        'severity' => "error",
	      }


Following this there are the node classifications.  Here we are providing the default site.pp classifications that will configure a ScaleIO cluster from scratch using 3 nodes and multiple components per node.

Notice that there are extra fields being represented in the node classifications that may not naturally seem like they are required based on the node name.  In the below examples, we are setting up multi-role nodes by specifying multiple components which may require the extra parameters.

  * The following is a dedicated MDM or Tie-Breaker node:

	node /mdm|tb/ {
	  class {'::scaleio2':
	        password => $password,
	        version => $version,
	        mdm_ip => $mdm_ip,
	        tb_ip => $tb_ip,
	        cluster_name => $cluster_name,
	        callhome_cfg => $callhome_cfg,
          sio_sds => $sio_sds,
          sio_sdc => $sio_sdc,
	        components => ['mdm','lia','callhome'],
	  }
	}

  * The following is a dedicated Gateway node:

  	node /gw/ {
  	  class {'::scaleio':
  	        password => $password,
  	        version => $version,
  	        mdm_ip => $mdm_ip,
  	        components => ['gateway'],
  	  }
  	}

  * The following is a management node:

  	node /mgmt/ {
  	  class {'::scaleio2':
  	        password => $password,
  	        version => $version,
  	        mdm_ip => $mdm_ip,
  	        tb_ip => $tb_ip,
  	        cluster_name => $cluster_name,
  	        callhome_cfg => $callhome_cfg,
            sio_sds => $sio_sds,
            sio_sdc => $sio_sdc,
  	        components => ['mdm', 'lia', 'callhome', 'gateway'],
  	  }
  	}

  * The following is a dedicated SDS node:

  	node /sds/ {
  	  class {'::scaleio2':
  	        version => $version,
  	        mdm_ip => $mdm_ip,
  	        components => ['sds','lia'],
  	  }
  	}

  * The following is a dedicated SDC node:

  	node /sdc/ {
  	  class {'::scaleio2':
  	        version => $version,
  	        mdm_ip => $mdm_ip,
  	        components => ['sdc', 'lia'],
  	  }
  	}

  * The following is a hyperconverged node:

    node /hyp/ {
      class {'::scaleio2':
            version => $version,
            mdm_ip => $mdm_ip,
            components => ['sdc', 'sds', 'lia'],
      }
    }

See <http://github.com/emccode/vagrant-puppet-scaleio> for a working example of a whole site.pp file.


## Reference

* puppetlabs-stdlib
* puppetlabs-firewall
* puppetlabs-java
* puppetlabs-apt
* dalen-dnsquery

## Limitations

This module currently only support Redhat 7.x and was developed against CentOS 7.x.
This module works in append only mode:
  - No manipulation (resize/delete/snapshot/etc)
    > NOTE: Use ViPR Controller or CoprHD for volumes manipulation

## Development

We encourage the community to actively contribute to this module.

* Fork the repository
* Clone
* Add original repository as upstream
* Checkout new branch
* Commit changes
* Push to your repository
* Issue pull request

## TODO
* Repositories APT and Zypper: repo
* Tests and validation
* Update lib/Facters
* Update Examples under tests/vagrant 

## Contributors

* Eoghan Kelleher
* Jonas Rosland
* Clint Kitson
* Victor da Costa
