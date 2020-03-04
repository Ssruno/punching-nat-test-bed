# punching-nat-test-bed
Test bed for hole punching NATs

TODO: 

Add Google DNS to hosts
envimation/ubuntu-xenial check current version, and hardcode it.
Do diagram

check debconf

    gw_a: debconf: unable to initialize frontend: Dialog
    gw_a: debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76, <> line 2.)
    gw_a: debconf: falling back to frontend: Readline
    gw_a: debconf: unable to initialize frontend: Readline
    gw_a: debconf: (This frontend requires a controlling tty.)
    gw_a: debconf: falling back to frontend: Teletype
    gw_a: dpkg-preconfigure: unable to re-open stdin: 


    gw_a: WARNING: 
    gw_a: apt
    gw_a:  
    gw_a: does not have a stable CLI interface. 
    gw_a: Use with caution in scripts.



    gw_a: debconf: delaying package configuration, since apt-utils is not installed


make A reacH b in testing, and change the order, first NAT then provision.

Go in boxes directory and do
make base_vm