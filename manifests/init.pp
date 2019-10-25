# vim: set ts=2 sw=2 et:
Exec { path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/' }
$wiki = ['recettes.wiki', 'politique.wiki']

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
    command => '/usr/bin/wget -O /usr/src/dokuwiki.tgz https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz',
    creates => '/usr/src/dokuwiki.tgz'
  }
  
  # unzip dokuwiki
  exec { 'unzip':
    command => 'cd /usr/src && tar xavf dokuwiki.tgz && mv dokuwiki-2018-04-22b dokuwiki',
    provider => shell,
    require => Exec['download_dokuwiki'],
    creates => '/usr/src/dokuwiki'
  }
  
  # Create directory for virtualhost data
  $wiki.each |$wiki| {
    file { '/var/www/${wiki}':
      ensure => directory,
    }  
  }
}
#class apache{
#  package { 'apache2':
#    ensure  => installed,
#    name    => $apache,
#    require => Package['apache2'],
#  }
#}
