#!/bin/bash

# through manual excecution
# sudo suricata -c /etc/suricata/suricata.yaml -q 0 -D

# through service
sudo systemctl start suricata.service
sudo systemctl status suricata.service

tail -f /var/log/suricata/fast.log