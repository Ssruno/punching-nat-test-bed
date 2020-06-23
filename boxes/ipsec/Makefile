
base_vm:	
	vagrant destroy -f base_ipsec && \
	vagrant up base_ipsec --provision && \
	vagrant vbguest base_ipsec  --status && \
	vagrant vbguest base_ipsec --do install --auto-reboot && \
	vagrant reload && \
	vagrant vbguest base_ipsec  --status && \
	vagrant package --output ../bento-ubuntu-18-04-ipsec.box && \
	vagrant box add base-ipsec ../bento-ubuntu-18-04-ipsec.box && \
	rm -rf ../bento-ubuntu-18-04-ipsec.box && \
	vagrant destroy -f base_ipsec && \
	rm -rf .vagrant/
