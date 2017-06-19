#!/bin/sh
#Install script for Pocket EPC  snap


#Removing an already installed Quortus snap
sudo snap remove pocket-epc
echo "pocket-epc snap removed from the system"
#Installing Pocket EPC snap
sudo snap install pocket-epc_1.0_amd64.snap --dangerous
echo "pocket-epc snap installed "
#Connecting required slots with plugs
sudo snap connect pocket-epc:firewall-control
sudo snap connect pocket-epc:network-control
echo "firewall-control and network-control plugs are connected to pocket-epc snap"

#Restarting the Pocket EPC snap
sudo service snap.pocket-epc.ran stop
sleep 10
sudo service snap.pocket-epc.ran start
