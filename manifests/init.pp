node default{
	file{'fill motd':
	path => '/etc/motd',
	content => 'Hello world',
	}
}

node server0 {
	package { 'tmux':
	ensure => installed,
	name   => 'tmux',
   }
}
