Vagrant::Config.run do |config|
  config.vm.box       = 'precise64'
  config.vm.box_url   = '/Users/am/Downloads/precise64.box'
  config.vm.host_name = 'rails-dev-box'

  config.vm.forward_port 3000, 3000

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'
end