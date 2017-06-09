#!/bin/sh
#Install script for Quortus snap


#Removing an already installed Quortus snap
snap remove quortus-epc
echo "quortus-epc snap removed from the system"
#Installing Quortus snap
snap install quortus-epc_3.97.405_amd64.snap --dangerous
echo "quortus-epc snap installed "
#Connecting required slots with plugs
snap connect quortus-epc:firewall-control
snap connect quortus-epc:network-control
echo "firewall-control and network-control plugs are connected to quortus-epc snap"

#Restarting the Quortus snap
service snap.quortus-epc.ran stop
sleep 10
service snap.quortus-epc.ran start
