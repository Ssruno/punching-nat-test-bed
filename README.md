# Test bed for hole punching NATs
![Net Diagram](docs/test_bed_v0.3-alpha.png  "Net Diagram")
#### Tested with
- Vagrant (v 2.2.7)
	- box: "envimation/ubuntu-xenial"
- Virtualbox (v 6.1.4-2)
	- Networking mode of interfaces: "Internal networking" (intnet)
#### Name of hosts/VMs

- router
	- **eth1:** 172.18.1.1/16
	- **eth2:** 172.19.1.1/16
	- NAT:
		- iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
- gw_a
	- **eth1:** 10.40.40.40/24
	- **eth2:** 172.18.18.18/16
	- NAT:
		- iptables --table nat --append POSTROUTING --out-interface eth2 -j MASQUERADE
		- iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
- node_a1
	- **eth1:** 10.40.40.5/24
- gw_b
	- **eth1:** 10.40.40.40/24
	- **eth2:** 172.19.19.19/16
	- NAT:
		- iptables --table nat --append POSTROUTING --out-interface eth2 -j MASQUERADE
		- iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE	
- node_b1
	- **eth1:** 10.40.40.7/24
#### Run the test bed
	# Generate the base image
	cd boxes/base
	make base_vm
	# Run the test bed
	cd ../..
	vagrant up
	
To access the VMs, run:

	vagrant ssh <node_a1|gw_a|router|gw_b|node_b1>

#### DEBUG: 
- vagrant up --debug &> vagrant.log
- VBoxManage list --long intnets
- VBoxManage list --long runningvms
- VBoxManage list runningvms
- VBoxManage showvminfo <uuid|vmname> --machinereadable
- VBoxManage showvminfo <uuid|vmname> --details
- VBoxManage natnetwork list [<pattern>]
- vagrant vbguest base_punch  --status

#### TODO: 

- [ ] Add Google DNS to hosts
- [x] Check linked clones for Vagrant
- [x] For the default NAT interface of Vagrant, configure manually a different MAC and Space address
- [ ] Do we need promiscuous mode?
- [ ] Check if we need --natdnsproxy1 and --natdnsproxy1
- [ ] Try to loop the creationg process
- [x] Check vagrant-vbguest plugin for downloading the right VirtualBox Guest Additions
- [ ] Add references to documentation