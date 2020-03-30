
base_vm:	
	vagrant destroy -f base_punch && \
	vagrant up base_punch --provision && \
	vagrant vbguest base_punch  --status && \
	vagrant vbguest base_punch --do install --auto-reboot && \
	vagrant reload && \
	vagrant vbguest base_punch  --status && \
	vagrant package --output ../bento-ubuntu-16-04-punch-nat.box && \
	vagrant box add base-punch-nat ../bento-ubuntu-16-04-punch-nat.box && \
	rm -rf ../bento-ubuntu-16-04-punch-nat.box && \
	vagrant destroy -f base_punch && \
	rm -rf .vagrant/
