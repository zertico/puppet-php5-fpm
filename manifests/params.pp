# Class: php5fpm::params
#
# This class defines default parameters used by the main module class php5fpm
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to php5fpm class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class php5fpm::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'php5-fpm',
    default                   => 'php-fpm',
  }

  $service = $::operatingsystem ? {
    default => 'php5-fpm',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'php5-fpm',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/                           => 'www-data',
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => 'apache',
    default                                             => 'php5-fpm',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/                           => '/etc/php5/fpm',
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/etc/php-fpm.d',
    default                                             => '/etc/php-fpm',
  }

  $config_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/                           => '/etc/php5/fpm/php.ini',
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/etc/php-fpm.conf',
    default                                             => '/etc/php-fpm/php-fpm.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/php5-fpm',
    default                   => '/etc/sysconfig/php5-fpm',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/php5-fpm.pid',
  }

  $data_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/                           => '/etc/php5/fpm',
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/etc/php-fpm.d',
    default                                             => '/etc/php5-fpm',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/php5-fpm',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/php5-fpm/php5-fpm.log',
  }

  $port = ''
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
