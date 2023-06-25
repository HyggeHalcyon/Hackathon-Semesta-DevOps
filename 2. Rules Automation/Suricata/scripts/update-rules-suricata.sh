#!/bin/bash

# update open-source rules 
sudo suricata-update enable-source et/open
sudo suricata-update enable-source oisf/trafficid
sudo suricata-update enable-source tgreen/hunting

# update local rules
sudo suricata-update -o /etc/suricata/rules
sudo suricata-update -o /var/lib/suricata/rules/

# test suricata if suricata rules are functional properly
sudo suricata -T -c /etc/suricata/suricata.yaml -v

# reload the rules
sudo suricatasc -c ruleset-reload-nonblocking