## Evaluation of Network-Layer Security Technologies for Cloud Platforms

#### Description

We use vagrant with virtualbox to create virtual machines and emulate a network

#### Current Experiment
- [Slack Nebula with one (1) Lighthouse and simple nodes](nebula-with-simple-nodes/README.md "Slack Nebula with one (1) Lighthouse and simple nodes")

#### Previous Experiments
- [Simple network topology to try a NAT with iptables](simple-nat-test-bed/README.md "Simple network topology to try a NAT with iptables")
- [Slack Nebula with one (1) Lighthouse and many nodes](nebula-with-one-lighthouse/README.md "Slack Nebula with one (1) Lighthouse and many nodes")
- Slack Nebula with two (2) Lighthouses

#### Requeriments
- Some GNU/Linux
    - Tested with 4.14.171-1-MANJARO
- VirtualBox
    - Tested with Virtualbox (v 6.1.4-2)
- Vagrant
    - Tested with Vagrant (v 2.2.7)    
    - You can 'install' directly the [self-contained binary](https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_linux_amd64.zip) and avoid the struggle of dependency with Ruby
    - By 'install' I mean, just adding the binary to your $PATH enviroment variable, i.e. in .bashrc

>        # We add vagrant binary 2.2.7
>        export PATH="$HOME/path/to/recently/downloaded/vagrant/bin:$PATH"

#### How to proceed

- First, we need to generate the base 'box' from vagrant, that would be used as a template for all the other virtual machines. [Instructions here](boxes/README.md "Instructions here").
- You don't need much Disk space, because we use the parameter 'linked_clone'. There would be only one virtual machine used as a template with the actual 'size' of ~2,3 GB), all the other VMs would have only ~5,5 MB.
- Tested with 16 GB of RAM and currently uses 512 MB of RAM per each node with the box 'bento/ubuntu-16.04'.

#### Others
- Aalto University
- KTH Royal Institute of Technology
