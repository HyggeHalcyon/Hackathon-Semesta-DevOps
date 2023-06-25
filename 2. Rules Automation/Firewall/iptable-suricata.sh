#!/bin/bash

# RESET ALL RULES
iptables -F
iptables -X
iptables -Z

# drop all forwarding packets
sudo iptables -I FORWARD -j DROP

# enable suricata rules for host layer
sudo iptables -I INPUT -p tcp --dport 22 -j NFQUEUE --queue-bypass
sudo iptables -A INPUT -j NFQUEUE
sudo iptables -I OUTPUT -p tcp --dport 22 -j NFQUEUE --queue-bypass
sudo iptables -A OUTPUT -j NFQUEUE