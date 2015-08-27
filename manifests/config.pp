# Define : php5fpm::config
#
# Define a php-fpm config snippet. Places all config snippets into
# /etc/php5/fpm/pool.d, where they will be automatically loaded
#
# Parameters :
#    * ensure: typically set to "present" or "absent".
#       Defaults to "present"
#    * content: set the content of the config snipppet.
#       Defaults to    'template("php5-fpm/pool.d/$name.conf.erb")'
#    * order: specifies the load order for this config snippet.
#       Defaults to "500"
#
# Sample Usage:
#    php5fpm::config { "global":
#        ensure => present,
#        order  => '000',
#    }
#    php5fpm::config { "www-example-pool":
#        ensure     => present,
#        content    => template("php5-fpm/pool.d/www-pool.conf.erb"),
#    }
#

define php5fpm::config (
  $ensure                    = present,
  $content                   = '',
  $order                     = '500',
  $poolname                  = '',
  $owner                     = '',
  $groupowner                = '',
  $display_errors            = 'off',
  $log_errors                = 'off',
  $max_execution_time        = '0',
  $memory_limit              = '32M',
  $pm_max_children           = '5',
  $pm_max_requests           = '500',
  $pm_max_spare_servers      = '35',
  $pm_min_spare_servers      = '5',
  $pm_start_servers          = '20',
  $process_manager           = 'static',
  $request_slowlog_timeout   = '0',
  $setenv                    = [],
  ) {

  include php5fpm
  include php5fpm::params

  $real_owner = $owner ? {
    ''      => $php5fpm::process_user,
    default => $owner,
  }

  $real_groupowner = $groupowner ? {
    ''      => $real_owner,
    default => $groupowner,
  }

  $real_poolname = $owner ? {
    ''      => 'www',
    default => $real_owner,
  }

  $real_content = $content ? {
    ''      => 'php5fpm/pool.d/www-pool.conf.erb',
    default => $content,
  }

  file { "${order}-${name}.conf":
    ensure  => $ensure,
    path    => "${php5fpm::config_dir}/pool.d/${order}-${name}.conf",
    content => template($real_content),
    mode    => '0644',
    owner   => root,
    group   => root,
    notify  => Service[$php5fpm::service],
    require => Package[$php5fpm::package],
  }

  file { "php5-fpm-${name}.log.slow":
    ensure  => $ensure,
    path    => "${php5fpm::log_dir}/php5-fpm-${name}.log.slow",
    mode    => '0664',
    owner   => $real_owner,
    group   => $real_groupowner,
    notify  => Service[$php5fpm::service],
    require => File[$php5fpm::log_dir],
  }

  # Cleans up configs not managed by php5-fpm module
  exec { "cleanup-pool-${name}":
    cwd     => "${php5fpm::config_dir}/pool.d/",
    path    => '/usr/bin:/usr/sbin:/bin',
    command => "find -name '[^0-9]*.conf' -exec rm {} +",
    unless  => "test -z $(find -name '[^0-9]*.conf')",
    notify  => Service[$php5fpm::service],
    require => Package[$php5fpm::package],
  }
}
