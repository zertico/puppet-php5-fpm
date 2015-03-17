# Puppet module: php5fpm

This is a Puppet module for php5fpm based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-php5fpm

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install php5fpm with default settings

        class { 'php5fpm': }

* Install a specific version of php5fpm package

        class { 'php5fpm':
          version => '1.0.1',
        }

* Disable php5fpm service.

        class { 'php5fpm':
          disable => true
        }

* Remove php5fpm package

        class { 'php5fpm':
          absent => true
        }

* Enable auditing without without making changes on existing php5fpm configuration *files*

        class { 'php5fpm':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'php5fpm':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'php5fpm':
          source => [ "puppet:///modules/example42/php5fpm/php5fpm.conf-${hostname}" , "puppet:///modules/example42/php5fpm/php5fpm.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'php5fpm':
          source_dir       => 'puppet:///modules/example42/php5fpm/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'php5fpm':
          template => 'example42/php5fpm/php5fpm.conf.erb',
        }

* Automatically include a custom subclass

        class { 'php5fpm':
          my_class => 'example42::my_php5fpm',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'php5fpm':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'php5fpm':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'php5fpm':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'php5fpm':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

[![Build Status](https://travis-ci.org/zertico/puppet-php5fpm.png?branch=master)](https://travis-ci.org/zertico/puppet-php5fpm)