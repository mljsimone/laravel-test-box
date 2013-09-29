Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.forward_port 80, 8080
  config.vm.provision :shell, :path => "bootstrap.sh"
end
