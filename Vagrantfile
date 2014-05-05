VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise64"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.55.11"

  # config.vm.network "public_network"

  # config.ssh.forward_agent = true

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode
  #   vb.gui = true
     vb.customize ["modifyvm", :id, "--memory", "4096"]
  end

  config.vm.provision :shell, :path => "upgrade_puppet.sh"

  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.module_path = "modules"
     puppet.manifest_file  = "site.pp"
     puppet.hiera_config_path  = "hiera.yml"
     puppet.working_directory = "/tmp/vagrant-puppet-1"
     puppet.options = "--verbose --debug"
  end

end