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

  # install php7 package
  package { 'php7.3':
    require => Exec['apt-update'],        # require 'apt-update' before installing
    ensure => installed,
  }
  
  # download and install dokuwiki
  exec { 'download_dokuwiki':
    command => 'wget -O /usr/src/dokuwiki.tgz && https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz',
    provider => shell,
    onlyif => 'test -f /usr/src/'
  }
  
  # unzip dokuwiki
  exec { 'unzip':
    command => 'cd /usr/src && tar xavf dokuwiki.tgz && mv dokuwiki-2018-04-22b dokuwiki',
    user => 'root',
    provider => shell,
    require => Exec['download_dokuwiki'],
  }
}
#class apache{
#  package { 'apache2':
#    ensure  => installed,
#    name    => $apache,
#    require => Package['apache2'],
#  }
#}
