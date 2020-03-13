
base_vm:	
	vagrant destroy -f base_punch && \
	vagrant up base_punch --provision && \
	vagrant vbguest base_punch  --status && \
	vagrant vbguest base_punch --do install --auto-reboot && \
	vagrant reload && \
	vagrant vbguest base_punch  --status && \
	vagrant package --output ../envimation-ubuntu-xenial-punch-nat.box && \
	vagrant box add base-punch-nat ../envimation-ubuntu-xenial-punch-nat.box && \
	rm -rf ../envimation-ubuntu-xenial-punch-nat.box && \
	vagrant destroy -f base_punch && \
	rm -rf .vagrant/
