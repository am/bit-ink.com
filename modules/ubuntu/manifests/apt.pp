# == Class: ubuntu::apt
#
# Goes into manifests/apt.pp

class ubuntu::apt {
	exec { "apt-update":
		command => "/usr/bin/apt-get update"
	}
	package { "build-essential":
		ensure => present,
	}
}