## Network with one (1) Nebula lighthouse and only one node from each side
![Net Diagram](../docs/test_bed_v0.7-alpha.png  "Net Diagram")

### Description

There is one lighthouse (lighthouse1) that is connected to the router. Gateway A and B have a SNAT configured. After many trials, we added a delay to the router with the *tc* command (more details in the section below). Before the delay, **"node-a1" that belongs to the "Site A" could not reach "node-b1" that belongs to "Site B" and vice versa**. In any case, the nodes can reach the given Lighthouse without problems. After applying the delay, finally "node-a1" and "node-b1" can communicate; the purpose of the delay is to emulate the real delay on the Internet.

#### Before applied delay

From the "node-a1" we try to ping "node-b1", no success.
```
vagrant@node-a1:~$ ping -c 10 192.200.1.7
PING 192.200.1.7 (192.200.1.7) 56(84) bytes of data.

--- 192.200.1.7 ping statistics ---
10 packets transmitted, 0 received, 100% packet loss, time 9027ms
```
Here the `conntrack -L --src-nat` of both gateways (check the dport=1024 in gw-b):
```
vagrant@gw-a:~$ sudo conntrack -L -j
udp      17 27 src=10.40.40.5 dst=172.19.19.19 sport=5555 dport=7777 [UNREPLIED] src=172.19.19.19 dst=172.18.18.18 sport=7777 dport=5555 mark=0 use=1
udp      17 176 src=10.40.40.5 dst=172.20.1.100 sport=5555 dport=4242 src=172.20.1.100 dst=172.18.18.18 sport=4242 dport=5555 [ASSURED] mark=0 use=1
conntrack v1.4.3 (conntrack-tools): 2 flow entries have been shown.

vagrant@gw-b:~$ sudo conntrack -L -j
udp      17 29 src=10.40.40.7 dst=172.18.18.18 sport=7777 dport=5555 [UNREPLIED] src=172.18.18.18 dst=172.19.19.19 sport=5555 dport=1024 mark=0 use=1
udp      17 175 src=10.40.40.7 dst=172.20.1.100 sport=7777 dport=4242 src=172.20.1.100 dst=172.19.19.19 sport=4242 dport=7777 [ASSURED] mark=0 use=1
conntrack v1.4.3 (conntrack-tools): 2 flow entries have been shown.
```

However, If we change the [config file](config/node-b1/config.yml "config file") of the "node-b1" and we set `delay: 0s` under the punchy directive, we obtain the same clash of a tuple in conntrack but this time on the Gateway A.

```
vagrant@gw-a:~$ sudo conntrack -L -j
udp      17 29 src=10.40.40.5 dst=172.19.19.19 sport=5555 dport=7777 [UNREPLIED] src=172.19.19.19 dst=172.18.18.18 sport=7777 dport=1024 mark=0 use=1
udp      17 177 src=10.40.40.5 dst=172.20.1.100 sport=5555 dport=4242 src=172.20.1.100 dst=172.18.18.18 sport=4242 dport=5555 [ASSURED] mark=0 use=1
conntrack v1.4.3 (conntrack-tools): 2 flow entries have been shown.

vagrant@gw-b:~$ sudo conntrack -L -j
udp      17 27 src=10.40.40.7 dst=172.18.18.18 sport=7777 dport=5555 [UNREPLIED] src=172.18.18.18 dst=172.19.19.19 sport=5555 dport=7777 mark=0 use=1
udp      17 176 src=10.40.40.7 dst=172.20.1.100 sport=7777 dport=4242 src=172.20.1.100 dst=172.19.19.19 sport=4242 dport=7777 [ASSURED] mark=0 use=1
conntrack v1.4.3 (conntrack-tools): 2 flow entries have been shown.
```

#### After applied delay

On **router** during provisioning we added:

```
# We add some delay on the interfaces towards site A and site B, to have the sum of 500ms in total. 
# Without this delay, there is some port reallocation happening with the NAT when the hole punch takes place.
sudo tc qdisc add dev eth1 root netem delay 250ms
sudo tc qdisc add dev eth2 root netem delay 250ms
```

Again we proceed with the ping as before (this time successful), remember that "node-b1" was set with `delay: 0s` under the punchy directive:

```
vagrant@node-a1:~$ ping -c 5 192.200.1.7
PING 192.200.1.7 (192.200.1.7) 56(84) bytes of data.
64 bytes from 192.200.1.7: icmp_seq=1 ttl=64 time=1408 ms
64 bytes from 192.200.1.7: icmp_seq=2 ttl=64 time=509 ms
64 bytes from 192.200.1.7: icmp_seq=3 ttl=64 time=507 ms
64 bytes from 192.200.1.7: icmp_seq=4 ttl=64 time=506 ms
64 bytes from 192.200.1.7: icmp_seq=5 ttl=64 time=505 ms

--- 192.200.1.7 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4006ms
rtt min/avg/max/mdev = 505.607/687.654/1408.651/360.500 ms, pipe 2
```

Now we can see `conntrack -L -j` of both gateways with the proper **ASSURED** directive.

```
vagrant@gw-a:~$ sudo conntrack -L -j
udp      17 175 src=10.40.40.5 dst=172.19.19.19 sport=5555 dport=7777 src=172.19.19.19 dst=172.18.18.18 sport=7777 dport=5555 [ASSURED] mark=0 use=1
udp      17 174 src=10.40.40.5 dst=172.20.1.100 sport=5555 dport=4242 src=172.20.1.100 dst=172.18.18.18 sport=4242 dport=5555 [ASSURED] mark=0 use=1
conntrack v1.4.3 (conntrack-tools): 2 flow entries have been shown.

vagrant@gw-b:~$ sudo conntrack -L -j
udp      17 170 src=10.40.40.7 dst=172.18.18.18 sport=7777 dport=5555 src=172.18.18.18 dst=172.19.19.19 sport=5555 dport=7777 [ASSURED] mark=0 use=1
udp      17 171 src=10.40.40.7 dst=172.20.1.100 sport=7777 dport=4242 src=172.20.1.100 dst=172.19.19.19 sport=4242 dport=7777 [ASSURED] mark=0 use=1
conntrack v1.4.3 (conntrack-tools): 2 flow entries have been show
```

#### Timing issue

If we set the `delay: 1s` under the punchy directive, or `delay: 0s` sometimes works, and sometimes does not. The only way to make the connection established as **ASSURED** is when you ping A->B and A<-B at the “same time”. It is not possible to do it simultaneously but when it is quick enough, we can fool the NAT and avoid the clash of ports, therefore it achieve a single stream of data.

#### Run the test bed

First you need to [install the base box image](../boxes/README.md "install the base box image"), then proceed with:

	vagrant up
	
To access the VMs, run:

	vagrant ssh <lighthouse1|node_a1|gw_a|router|gw_b|node_b1|>

If you want to make changes on the Nebula setup (YAML files) without rebooting the entire VMs, you can do a 'make restart' and it would "restart" the Nebula 'daemons' on the nodes

>	`make restart`

#### List of Virtual Machines
- router
- gw_a
- node_a1
- gw_b
- node_b1


#### Tested with
- GNU/Linux 4.14.171-1-MANJARO
- Vagrant (v 2.2.7)
	- box: "base_punch", [see the docs](../boxes/README.md "see the docs").
- Virtualbox (v 6.1.4-2)
	- Networking mode of interfaces: "Internal networking" (intnet)
- Nebula v 1.2.0

#### DEBUG: 
- On the "logs" folder/directory of this project you can find the (realtime) output of nebula with "debug" level of verbosity
- Check the NAT on the gateways A or B with
	- `sudo conntrack -E --src-nat`
- On "router"
	- `sudo tcpdump -i eth1 udp -vv -X`
	- `sudo tcpdump -i any -e -s 0 'net 172.0.0.0/8 and (udp or icmp) and not net 172.20.0.0/16 and not net 192.168.0.0/16'	`
- On "gw_a"
	- `sudo iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP`
	- `sudo conntrack -L --src-nat`
- On "node_a1"
	- `echo -n "TESTING" | nc -u 172.20.1.100 4242`

#### TODO: 

- [ ] Todo

#### Name of hosts/VMs

#### router

- **eth0:** `192.168.111.15/24 "Fake Internet" (and also Vagrant mandatory interface) / Default Gateway`
- **eth1:** `172.18.1.1/16`
- **eth2:** `172.19.1.1/16`
- **eth3:** `172.20.1.10/16`
- NAT:
	- `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`
- Kernel IP routing table	
```
		Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
		default         192.168.111.2   0.0.0.0         UG    0      0        0 eth0
		172.18.0.0      *               255.255.0.0     U     0      0        0 eth1
		172.19.0.0      *               255.255.0.0     U     0      0        0 eth2
		172.20.0.0      *               255.255.0.0     U     0      0        0 eth3
		192.168.111.0   *               255.255.255.0   U     0      0        0 eth0	
```

#### gw_a

- **eth0:** `192.168.112.15/24 Vagrant mandatory interface`
- **eth1:** `10.40.40.40/24`
- **eth2:** `172.18.18.18/16 Default Gateway`
- NAT:
	- `iptables --table nat --append POSTROUTING --out-interface eth2 -j SNAT --to-source 172.18.18.18`
- Kernel IP routing table
```	
		Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
		default         172.18.1.10     0.0.0.0         UG    0      0        0 eth2
		10.40.40.0      *               255.255.255.0   U     0      0        0 eth1
		172.18.0.0      *               255.255.0.0     U     0      0        0 eth2
		192.168.112.0   *               255.255.255.0   U     0      0        0 eth0	
```		

#### node_a1

- **eth0:** `192.168.113.15/24 Vagrant mandatory interface`
- **eth1:** `10.40.40.5/24 Default Gateway`
- **nebula1:** `192.200.1.5/24 Virtual Interface for Nebula`
- Kernel IP routing table
```
		Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
		default         10.40.40.40     0.0.0.0         UG    0      0        0 eth1
		10.40.40.0      *               255.255.255.0   U     0      0        0 eth1
		192.168.113.0   *               255.255.255.0   U     0      0        0 eth0
		192.200.1.0     *               255.255.255.0   U     0      0        0 nebula1
```		

#### gw_b

- **eth0:** `192.168.114.15/24 Vagrant mandatory interface`
- **eth1:** `10.40.40.40/24`
- **eth2:** `172.19.19.19/16 Default Gateway`
- NAT:
	- `iptables --table nat --append POSTROUTING --out-interface eth2 -j SNAT --to-source 172.19.19.19`
- Kernel IP routing table		
```	
		Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
		default         172.19.1.10     0.0.0.0         UG    0      0        0 eth2
		10.40.40.0      *               255.255.255.0   U     0      0        0 eth1
		172.19.0.0      *               255.255.0.0     U     0      0        0 eth2
		192.168.114.0   *               255.255.255.0   U     0      0        0 eth0
```

#### node_b1

- **eth0:** `192.168.115.15/24 Vagrant mandatory interface`
- **eth1:** `10.40.40.7/24 Default Gateway`
- **nebula1:** `192.200.1.7/24 Virtual Interface for Nebula`
- Kernel IP routing table
```	
		Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
		default         10.40.40.40     0.0.0.0         UG    0      0        0 eth1
		10.40.40.0      *               255.255.255.0   U     0      0        0 eth1
		192.168.115.0   *               255.255.255.0   U     0      0        0 eth0
		192.200.1.0     *               255.255.255.0   U     0      0        0 nebula1
```
