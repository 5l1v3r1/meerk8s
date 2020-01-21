#!/bin/bash



INT_NAMES=$(ip link show | grep -Po '(?<=:\W).*(?=:.*PROMISC)')
echo "Promisc. Ports: $INT_NAMES"


suricata -c /etc/suricata/suricata.yaml -i $INT_NAMES
