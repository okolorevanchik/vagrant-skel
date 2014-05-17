# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
   config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  #  config.vm.synced_folder "path/to/project", "/home/vagrant/project"

  # Enable shell provisioning
  config.vm.provision "shell", path: "./vagrant.d/pre-puppet.sh"

  ### Define VM for RabbitMQ
  config.vm.define "rmq", primary: true do |rmq|

      # Provider-specific configuration so you can fine-tune various
      # backing providers for Vagrant. These expose provider-specific options.
      # Example for VirtualBox:
      #
      rmq.vm.provider :virtualbox do |vb|
          # Don't boot with headless mode
          vb.gui = false

          # Use VBoxManage to customize the VM. For example to change memory:
          vb.customize ["modifyvm", :id, "--memory", "1024"]
      end

      # Networking options
      rmq.vm.network :private_network, ip: "192.168.100.5"
      rmq.vm.hostname = "rmq.example.com"

      # Enable provisioning with Puppet stand alone.  Puppet manifests
      # are contained in a directory path relative to this Vagrantfile.
      # You will need to create the manifests directory and a manifest in
      # the file base.pp in the manifests_path directory.
      #
      rmq.vm.provision :puppet do |puppet|
         puppet.manifests_path = "./vagrant.d/manifests"
         puppet.manifest_file  = "site-rmq.pp"
         puppet.module_path = "./vagrant.d/modules"
         puppet.options = "--fileserver=/vagrant/vagrant.d/fileserver.conf --verbose --debug"
      end    
  end
end