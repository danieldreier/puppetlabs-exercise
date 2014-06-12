    # -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if defined? VagrantPlugins::Cachier
  # Cache yum update files using vagrant-cachier, if installed
    config.cache.auto_detect = true
  end
  if defined? VagrantPlugins::Vbguest
    # set auto_update to false, if you do NOT want to check the correct
    # additions version when booting this machine
    config.vbguest.auto_update = false
  end

  config.vm.define :webserver do |node|
    node.vm.box = "ubuntu-server-12042-x64-vbox4210-nocm"
    node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'
    node.vm.hostname = 'webserver.boxnet'

#    config.vm.synced_folder "site", "/etc/puppet/va",
#      id: "site-module",
#      owner: "root",
#      group: "root",
#      mount_options: ["dmode=555,fmode=444"]

    config.vm.synced_folder "./hieradata", "/etc/puppet/hieradata",
      id: "site-module-data",
      mount_options: ["dmode=775,fmode=664"]

    # Hack to get ruby 1.9.3 in place before librarian-puppet runs
#    config.vm.provision "shell",
#      inline: "apt-get update; apt-get install -y ruby1.9.1 ruby1.9.1-dev rubygems"
#    config.vm.provision "shell",
#      inline: "update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby1.9.1.1.gz --slave /usr/bin/ri ri /usr/bin/ri1.9.1 --slave /usr/bin/irb irb /usr/bin/irb1.9.1 --slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1; update-alternatives --set gem /usr/bin/gem1.9.1 ; update-alternatives --set ruby /usr/bin/ruby1.9.1"

    config.vm.provision "shell", path: "example/install_puppet.sh"
    config.vm.provision "shell",
      inline: "puppet apply /vagrant/example/pre-provision.pp; puppet apply /vagrant/site/manifests"

    node.vm.network :forwarded_port, guest: 8000, host: 8000

    node.vm.network :private_network, ip: "192.168.33.14"

    node.vm.provider :virtualbox do |vb|
       vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "4", "--ioapic", "on"]
    end
  end
end
