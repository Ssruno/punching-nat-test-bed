
restart:
	vagrant ssh lighthouse1 -c 'sudo pkill nebula; sudo nohup /vagrant/files/nebula -config /vagrant/config/lighthouse1/config.yml &> /vagrant/logs/lighthouse1.out& sleep 1'
	vagrant ssh node_a1 -c 'sudo pkill nebula; sudo nohup /vagrant/files/nebula -config /vagrant/config/node-a1/config.yml &> /vagrant/logs/node_a1.out& sleep 1'
	vagrant ssh node_a2 -c 'sudo pkill nebula; sudo nohup /vagrant/files/nebula -config /vagrant/config/node-a2/config.yml &> /vagrant/logs/node_a2.out& sleep 1'
	vagrant ssh node_b1 -c 'sudo pkill nebula; sudo nohup /vagrant/files/nebula -config /vagrant/config/node-b1/config.yml &> /vagrant/logs/node_b1.out& sleep 1'
	vagrant ssh node_b2 -c 'sudo pkill nebula; sudo nohup /vagrant/files/nebula -config /vagrant/config/node-b2/config.yml &> /vagrant/logs/node_b2.out& sleep 1'
	vagrant ssh node_f1 -c 'sudo pkill nebula; sudo nohup /vagrant/files/nebula -config /vagrant/config/node-f1/config.yml &> /vagrant/logs/node_f1.out& sleep 1'
