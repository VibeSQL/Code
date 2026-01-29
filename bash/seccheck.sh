#!/usr/bin/bash

#
# Check status of important services
# Tested on Fedora Linux 43
#

# Define the services and variables
PINK='\033[1;35m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'
services=("mullvad-daemon" "firewalld" "NetworkManager" "sshd")
sestatus=$(getenforce)
relay=$(mullvad status |grep Relay |awk '{print $2}')

echo " Security Check Report"
echo " ====="
# Check SELinux status
if [ $sestatus != "Enforcing" ];
then
	echo -e " Status: $RED Selinux not Enforcing${NC}"
else
	echo -e " SELinux: $YELLOW "$sestatus"${NC}"
fi
#
# Loop through each service

for service in "${services[@]}"; do
    if systemctl is-enabled "$service" &> /dev/null; 
then
    echo -e " Status: $service: ${PINK}ok${NC}"
else
    echo -e " Status: $service: ${RED}not enabled${NC}"
fi
done

echo " ====="
    if [ ! -z $relay ];
then
    echo "VPN Connection info:"
    echo -e " ${PINK}$relay${NC}"
else
    echo -e " ${RED}VPN not connected${NC}"
fi