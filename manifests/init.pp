node default{
	file{'fill motd':
	path => '/etc/motd',
	content => 'hello world',
	}
}

node server0 {
	package { 'tmux':
	ensure => installed,
	name   => 'tmux',
   }
}
