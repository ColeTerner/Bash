#!/bin/bash
echo 'Write IP:'
read ip

current_mtu=$(sshpass -p 'detect-pwd' ssh detect@$ip "ip a | grep mtu | grep tun0 | awk '{print $5}'"
echo "Current MTU on tun0 network interface at host $ip  - $current_mtu"

