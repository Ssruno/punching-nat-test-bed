# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "envimation/ubuntu-xenial"

  # TODO: Add Google DNS Resolvers

  # =====================================
  # Site A
  # =====================================

  # Node A1
  config.vm.define "node_a1" do |node_a1|
    node_a1.vm.box = "envimation/ubuntu-xenial"
    node_a1.vm.network "private_network", ip: "10.1.0.2", netmask: "255.255.255.0"
    node_a1.vm.hostname = "a1.node"

    # Configuring Network Gateway for Node A1 in Site A
    node_a1.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    node_a1.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    node_a1.vm.provision :shell, inline: "route add default gw 10.1.0.1 eth1 2>/dev/null || true", run: "always"    
    node_a1.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"
  end

  # Gateway Site A
  config.vm.define "gw_a" do |gw_a|
    gw_a.vm.box = "envimation/ubuntu-xenial"
    gw_a.vm.network "private_network", ip: "10.1.0.1"
    gw_a.vm.network "private_network", ip: "172.16.16.16", netmask: "255.255.0.0"
    gw_a.vm.hostname = "a.gw" 
  end  

  # =====================================
  # Site B
  # =====================================

  # Node B1
  config.vm.define "node_b1" do |node_b1|
    node_b1.vm.box = "envimation/ubuntu-xenial"
    node_b1.vm.network "private_network", ip: "10.2.0.2", netmask: "255.255.255.0"
    node_b1.vm.hostname = "b1.node"

    # Configuring Network Gateway for Node B1 in Site B
    node_b1.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    node_b1.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    node_b1.vm.provision :shell, inline: "route add default gw 10.2.0.1 eth1 2>/dev/null || true", run: "always"    
    node_b1.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"
  end

  # Gateway Site B
  config.vm.define "gw_b" do |gw_b|
    gw_b.vm.box = "envimation/ubuntu-xenial"
    gw_b.vm.network "private_network", ip: "10.2.0.1"
    gw_b.vm.network "private_network", ip: "172.30.30.30", netmask: "255.255.0.0"
    gw_b.vm.hostname = "b.gw"
  end  

  # =====================================
  # Router
  # =====================================
  config.vm.define "router" do |router|
    router.vm.box = "envimation/ubuntu-xenial"
    router.vm.network "private_network", ip: "172.16.1.1", netmask: "255.255.0.0"
    router.vm.network "private_network", ip: "172.30.1.1", netmask: "255.255.0.0"
    router.vm.hostname = "router"
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
