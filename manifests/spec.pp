# Class: php5fpm::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class php5fpm::spec inherits php5fpm {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "php5fpm": template => "php5fpm/spec.erb" }

  File['php5fpm.conf'] {
    content => template('php5fpm/spec.erb'),
  }

}
