# == Class: jekyll::jekyll
#
# Goes into manifests/jekyll.pp

class jekyll::jekyll {
	# resources
	package { "rubygems":
		ensure => present,
	}
	package { "ruby1.9.1-dev":
		ensure => present,
	}
	package { "ruby1.8-dev":
		ensure => present,
	}
	package {'jekyll':
		ensure  => latest,
		provider=> 'gem',
		require    => Package['rubygems', 'ruby1.8-dev', 'ruby1.9.1-dev', 'build-essential'],
	}
	package {'stasis':
		ensure  => latest,
		provider=> 'gem',
		require    => Package['rubygems', 'ruby1.8-dev', 'ruby1.9.1-dev', 'build-essential'],
	}
}
