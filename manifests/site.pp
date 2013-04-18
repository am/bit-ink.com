# Normally goes to /etc/puppet/manifests/site.pp
node default {
  include ubuntu::apt
  include ubuntu::profile
  include jekyll::jekyll
  include stasis::stasis
}

# Set default path for Exec calls
Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/sbin/', '/usr/local/bin' ]
}
