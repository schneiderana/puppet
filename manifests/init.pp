# vim: set ts=2 sw=2 et:

node server0 {
# execute 'apt-get update'
  exec { 'apt-update':                    # exec resource named 'apt-update'
    command => '/usr/bin/apt-get update'  # command this resource will run
  }

# install apache2 package
  package { 'apache2':
    require => Exec['apt-update'],        # require 'apt-update' before installing
    ensure => installed,
  }

# ensure apache2 service is running
  service { 'apache2':
    ensure => running,
  }
}
#class apache{
#  package { 'apache2':
#    ensure  => installed,
#    name    => $apache,
#    require => Package['apache2'],
#  }
#}
