## Base box 'base_punch' for NAT

#### List of boxes (only 1 for now)
- base (directory) 
    - base_punch (box)

#### Details about the box in use
- Vagrant box: "bento/ubuntu-16.04" (Virtualbox)
- Vagrant plugin: "vagrant-vbguest"
    - Used for installing the Guest Addition version from the Host into the Guest
- Vagrant plugin: "vagrant-reload"
    - To upgrade the system, re-boot, and continue with the provision

#### Generate the base image

    cd base
	make base_vm

#### Description of the procedure
- We destroy (if previously exists) the base_punch VM.
- We run the 'vagrant up' to create Virtualbox virtual machine.
    - During the creation, installs the plugin "vagrant-vbguest" on the host if is not present.
    - Complicated setup to enable the directory /tmp/mount to have permissions to install the Guest Addition
    - Not to worry about the following error message, is just a warning for Windows Guests (Not our case):

        An error occurred during installation of VirtualBox Guest Additions 6.1.4. Some functionality may not work as intended.
        In most cases it is OK that the "Window System drivers" installation failed.

- We provision the VM
    - We enable IP forwarding on the VM
    - We install some tools, including iptables    
- We run the "vagrant-vbguest" to install (and match) the Guest Adition version from the Host into the Guest.
- We restart the Virtual machine
- We generate the 'box' (kind of snapshot) of the Virtual Machine just created.
- We add the recently generated box to Vagrant Host
    - You can check with 'vagrant box list'
    - The name of the added box is: 'base-punch-nat'
- Clean up

#### Verification

    $ vagrant box list
    base-punch-nat     (virtualbox, 0)
    bento/ubuntu-16.04 (virtualbox, 202002.04.0)