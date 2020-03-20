# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  # =====================================
  # Router
  # =====================================  
  config.vm.define "router" do |router|
    router.vm.box = "base-punch-nat"
    router.vm.hostname = "router"
    # Interface towards Site A
    router.vm.network "private_network", ip: "172.18.1.1", netmask: "255.255.0.0", virtualbox__intnet: true
    # Interface towards Site B
    router.vm.network "private_network", ip: "172.19.1.1", netmask: "255.255.0.0", virtualbox__intnet: true
    router.vm.provider "virtualbox" do |v|
      v.customize ['modifyvm', :id, '--intnet2', 'router-network-a']  # OK eth1 172.18.1.1
      v.customize ['modifyvm', :id, '--intnet3', 'router-network-b']  # OK eth2 172.19.1.1
      # This deals with the default vagrant interface, we force to use the address 192.168 instead 
      # of the 10.0 and we force the MAC address. Otherwise all vms has the same internal address
      v.customize ['modifyvm', :id, '--natnet1', '192.168.111.0/24']
      v.customize ['modifyvm', :id, '--macaddress1', "5CA1AB1E0041"]
      v.linked_clone = true
      v.name = "router"
    end        
    # Install some dependencies, and define the NAT
    router.vm.provision :shell, path: "router.sh"
    router.vm.post_up_message = "(Fake) 'ROUTER' that emulates the connection to the internet -- IS UP AND READY !!!"
  end

  # =====================================
  # Lighthouse
  # =====================================
  config.vm.define "lighthouse" do |lighthouse1|
    lighthouse1.vm.box = "base-punch-nat"
    # Interface 
    #lighthouse1.vm.network "private_network", ip: "172.20.1.100", netmask: "255.255.0.0", virtualbox__intnet: true
    
    lighthouse1.vm.hostname = "lighthouse1"

    # Setup nebula
    lighthouse1.vm.provision :shell, path: "lighthouse1.sh"    
    
    lighthouse1.vm.post_up_message = "(Lighthouse) 'lighthouse1' that emulates the connection to the nebula lighthouse -- IS UP AND READY !!!"
  end  

  # =====================================
  # Site A
  # =====================================
  # Gateway Site A
  config.vm.define "gw_a" do |gw_a|
    gw_a.vm.box = "base-punch-nat"
    gw_a.vm.hostname = "gw-a"
    gw_a.vm.network "private_network", ip: "10.40.40.40",  netmask: "255.255.255.0", virtualbox__intnet: true
    gw_a.vm.network "private_network", ip: "172.18.18.18", netmask: "255.255.0.0", virtualbox__intnet: true
    gw_a.vm.provider "virtualbox" do |v|
      v.customize ['modifyvm', :id, '--intnet2', 'site-a']            # OK eth1 10.40.40.40
      v.customize ['modifyvm', :id, '--intnet3', 'router-network-a']  # OK eth2 172.18.18.18
      # This deals with the default vagrant interface, we force to use the address 192.168 instead
      # of the 10.0 and we force the MAC address. Otherwise all vms has the same internal address      
      v.customize ['modifyvm', :id, '--natnet1', '192.168.112.0/24']
      v.customize ['modifyvm', :id, '--macaddress1', "5CA1AB1E0042"]
      v.linked_clone = true
      v.name = "gw-a"
    end
     # Configuring Network Gateway for Gateway A in Site A
    gw_a.vm.provision :shell, run: "always", inline: <<-SHELL
        echo 'Configuring Network Gateway' && \
        route del default gw 192.168.112.2 eth0 2>/dev/null || true && \
        route add default gw 172.18.1.1 eth2 2>/dev/null || true && \
        echo 'Network Gateway Configured' 
    SHELL
    # Install some dependencies, and define the NAT
    gw_a.vm.provision :shell, path: "gw_a.sh"
    gw_a.vm.post_up_message = "(Gateway) 'SITE A' that emulates the geographic site A -- IS UP AND READY !!!"
  end
  # Node A1
  config.vm.define "node_a1" do |node_a1|
    node_a1.vm.box = "base-punch-nat"
    node_a1.vm.hostname = "node-a1"
    node_a1.vm.network "private_network", ip: "10.40.40.5", netmask: "255.255.255.0", virtualbox__intnet: true
    node_a1.vm.provider "virtualbox" do |v|
      v.customize ['modifyvm', :id, '--intnet2', 'site-a']  # OK eth1 10.40.40.5
      # This deals with the default vagrant interface, we force to use the address 192.168 instead 
      # of the 10.0 and we force the MAC address. Otherwise all vms has the same internal address
      v.customize ['modifyvm', :id, '--natnet1', '192.168.113.0/24']
      v.customize ['modifyvm', :id, '--macaddress1', "5CA1AB1E0043"]
      v.linked_clone = true
      v.name = "node-a1"
    end
    # Configuring Network Gateway for Node A1 in Site A
    node_a1.vm.provision :shell, run: "always", inline: <<-SHELL
        echo 'Configuring Network Gateway' && \
        route del default gw 192.168.113.2 eth0 2>/dev/null || true && \
        route add default gw 10.40.40.40 eth1 2>/dev/null || true && \
        echo 'Network Gateway Configured' 
    SHELL
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
    gw_b.vm.hostname = "gw-b"
    gw_b.vm.network "private_network", ip: "10.40.40.40",  netmask: "255.255.255.0", virtualbox__intnet: true
    gw_b.vm.network "private_network", ip: "172.19.19.19", netmask: "255.255.0.0", virtualbox__intnet: true
    gw_b.vm.provider "virtualbox" do |v|
      v.customize ['modifyvm', :id, '--intnet2', 'site-b']            # OK eth1 10.40.40.40
      v.customize ['modifyvm', :id, '--intnet3', 'router-network-b']  # OK eth2 172.19.19.19
      # This deals with the default vagrant interface, we force to use the address 192.168 instead 
      # of the 10.0 and we force the MAC address. Otherwise all vms has the same internal address
      v.customize ['modifyvm', :id, '--natnet1', '192.168.114.0/24']
      v.customize ['modifyvm', :id, '--macaddress1', "5CA1AB1E0044"]
      v.linked_clone = true
      v.name = "gw-b"
    end
    # Configuring Network Gateway for Gateway B in Site B
    gw_b.vm.provision :shell, run: "always", inline: <<-SHELL
        echo 'Configuring Network Gateway' && \
        route del default gw 192.168.114.2 eth0 2>/dev/null || true && \
        route add default gw 172.19.1.1 eth2 2>/dev/null || true && \
        echo 'Network Gateway Configured' 
    SHELL
    # Install some dependencies, and define the NAT
    gw_b.vm.provision :shell, path: "gw_b.sh" #, privileged: false
    gw_b.vm.post_up_message = "(Gateway) 'SITE B' that emulates the geographic site B -- IS UP AND READY !!!"    
  end
  # Node B1
  config.vm.define "node_b1" do |node_b1|
    node_b1.vm.box = "base-punch-nat"
    node_b1.vm.hostname = "node-b1"
    node_b1.vm.network "private_network", ip: "10.40.40.7", netmask: "255.255.255.0", virtualbox__intnet: true
    node_b1.vm.provider "virtualbox" do |v|
      v.customize ['modifyvm', :id, '--intnet2', 'site-b']  #  eth1 10.40.40.7
      # This deals with the default vagrant interface, we force to use the address 192.168 instead 
      # of the 10.0 and we force the MAC address. Otherwise all vms has the same internal address
      v.customize ['modifyvm', :id, '--natnet1', '192.168.115.0/24']
      v.customize ['modifyvm', :id, '--macaddress1', "5CA1AB1E0045"]
      v.linked_clone = true
      v.name = "node-b1"
    end
    # Configuring Network Gateway for Node B1 in Site B
    node_b1.vm.provision :shell, run: "always", inline: <<-SHELL
        echo 'Configuring Network Gateway' && \
        route del default gw 192.168.115.2 eth0 2>/dev/null || true && \
        route add default gw 10.40.40.40 eth1 2>/dev/null || true && \
        echo 'Network Gateway Configured'
    SHELL
    # Install some dependencies
    node_b1.vm.provision :shell, path: "node_b1.sh" #, privileged: false
    node_b1.vm.post_up_message = "(Node) 'B1' that emulates an end point in site B -- IS UP AND READY !!!"
  end  

end
