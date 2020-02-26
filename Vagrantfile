# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  # config.vm.box = "envimation/ubuntu-xenial"

  # =====================================
  # Site A
  # =====================================

  # Node A1
  config.vm.define "node_a1" do |node_a1|
    node_a1.vm.box = "envimation/ubuntu-xenial"
    node_a1.vm.network "private_network", ip: "10.1.0.2", netmask: "255.255.255.0"
    node_a1.vm.hostname = "a1-node"

    # Install some dependencies
    node_a1.vm.provision :shell, path: "node_a1.sh", privileged: false

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
    gw_a.vm.hostname = "a-gw"

    # Install some dependencies, and define the NAT
    gw_a.vm.provision :shell, path: "gw_a.sh", privileged: false    

    # Configuring Network Gateway for Gateway A in Site A
    gw_a.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    gw_a.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    gw_a.vm.provision :shell, inline: "route add default gw 172.16.1.1 eth2 2>/dev/null || true", run: "always"    
    gw_a.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"    
  end  

  # =====================================
  # Site B
  # =====================================

  # Node B1
  config.vm.define "node_b1" do |node_b1|
    node_b1.vm.box = "envimation/ubuntu-xenial"
    node_b1.vm.network "private_network", ip: "10.2.0.2", netmask: "255.255.255.0"
    node_b1.vm.hostname = "b1-node"

    # Install some dependencies
    node_b1.vm.provision :shell, path: "node_b1.sh", privileged: false    

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
    gw_b.vm.hostname = "b-gw"

    # Install some dependencies, and define the NAT
    gw_b.vm.provision :shell, path: "gw_b.sh", privileged: false    

    # Configuring Network Gateway for Gateway B in Site B
    gw_b.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    gw_b.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    gw_b.vm.provision :shell, inline: "route add default gw 172.30.1.1 eth2 2>/dev/null || true", run: "always"    
    gw_b.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"        
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



  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
