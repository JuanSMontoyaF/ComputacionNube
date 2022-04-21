# -*- mode: ruby -*-
# vi: set ft=ruby :


$install_puppet = <<-PUPPET
sudo apt-get update -y
sudo apt-get install -y puppet
PUPPET


Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.hostname = "puppetServer"
  config.vm.network :private_network, ip: "192.168.90.3"
  config.vm.provision "shell", inline: $install_puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
  end
end
