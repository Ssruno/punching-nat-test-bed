# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  
  # =====================================
  # Router
  # =====================================
  config.vm.define "router" do |router|
    router.vm.box = "base-punch-nat"
    # Interface towards Site A
    router.vm.network "private_network", ip: "172.18.1.1", netmask: "255.255.0.0", virtualbox__intnet: true
    # Interface towards Site B
    router.vm.network "private_network", ip: "172.19.1.1", netmask: "255.255.0.0", virtualbox__intnet: true

    router.vm.hostname = "router"

    # Install some dependencies, and define the NAT
    router.vm.provision :shell, path: "router.sh"
    
    router.vm.post_up_message = "(Fake) 'ROUTER' that emulates the connection to the internet -- IS UP AND READY !!!"
  end


  # =====================================
  # Site A
  # =====================================

  # Gateway Site A
  config.vm.define "gw_a" do |gw_a|
    gw_a.vm.box = "base-punch-nat"
    gw_a.vm.network "private_network", ip: "10.40.40.40",  netmask: "255.255.255.0", virtualbox__intnet: true
    gw_a.vm.network "private_network", ip: "172.18.18.18", netmask: "255.255.0.0", virtualbox__intnet: true
    gw_a.vm.hostname = "gw-a"
 
    # Configuring Network Gateway for Gateway A in Site A
    gw_a.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    gw_a.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    gw_a.vm.provision :shell, inline: "route add default gw 172.18.1.1 eth2 2>/dev/null || true", run: "always"
    gw_a.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"    
    
    # Install some dependencies, and define the NAT
    gw_a.vm.provision :shell, path: "gw_a.sh"

    gw_a.vm.post_up_message = "(Gateway) 'SITE A' that emulates the geographic site A -- IS UP AND READY !!!"
  end

  # Node A1
  config.vm.define "node_a1" do |node_a1|
    node_a1.vm.box = "base-punch-nat"
    node_a1.vm.network "private_network", ip: "10.40.40.5", netmask: "255.255.255.0", virtualbox__intnet: true
    node_a1.vm.hostname = "node-a1"
    
    # Configuring Network Gateway for Node A1 in Site A
    node_a1.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    node_a1.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    node_a1.vm.provision :shell, inline: "route add default gw 10.40.40.40 eth1 2>/dev/null || true", run: "always"
    node_a1.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"
    
    # Install some dependencies
    node_a1.vm.provision :shell, path: "node_a1.sh"

    node_a1.vm.post_up_message = "(Node) 'A1' that emulates an end point in site A -- IS UP AND READY !!!"
  end  

  # =====================================
  # Site B
  # =====================================

  # Gateway Site B
  config.vm.define "gw_b" do |gw_b|
    gw_b.vm.box = "base-punch-nat"
    gw_b.vm.network "private_network", ip: "10.50.50.50",  netmask: "255.255.255.0", virtualbox__intnet: true
    gw_b.vm.network "private_network", ip: "172.19.19.19", netmask: "255.255.0.0", virtualbox__intnet: true
    gw_b.vm.hostname = "gw-b"
    
    # Configuring Network Gateway for Gateway B in Site B
    gw_b.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    gw_b.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    gw_b.vm.provision :shell, inline: "route add default gw 172.19.1.1 eth2 2>/dev/null || true", run: "always"
    gw_b.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"        
    
    # Install some dependencies, and define the NAT
    gw_b.vm.provision :shell, path: "gw_b.sh" #, privileged: false

    gw_b.vm.post_up_message = "(Gateway) 'SITE B' that emulates the geographic site B -- IS UP AND READY !!!"    
  end  

  # Node B1
  config.vm.define "node_b1" do |node_b1|
    node_b1.vm.box = "base-punch-nat"
    node_b1.vm.network "private_network", ip: "10.50.50.6", netmask: "255.255.255.0", virtualbox__intnet: true
    node_b1.vm.hostname = "node-b1"

    # Install some dependencies
    node_b1.vm.provision :shell, path: "node_b1.sh" #, privileged: false

    # Configuring Network Gateway for Node B1 in Site B
    node_b1.vm.provision :shell, inline: "echo 'Configuring Network Gateway'", run: "always"
    node_b1.vm.provision :shell, inline: "route del default gw 10.0.2.2 eth0 2>/dev/null || true", run: "always"
    node_b1.vm.provision :shell, inline: "route add default gw 10.50.50.50 eth1 2>/dev/null || true", run: "always"
    node_b1.vm.provision :shell, inline: "echo 'Network Gateway Configured'", run: "always"

    node_b1.vm.post_up_message = "(Node) 'B1' that emulates an end point in site B -- IS UP AND READY !!!"
  end  


  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
