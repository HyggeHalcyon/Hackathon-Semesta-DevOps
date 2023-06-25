#!/bin/bash

# through manual excecution
# PIDFILE=/var/run/suricata.pid
# PID=$(cat $PIDFILE)
# sudo kill -9 $PID
# sudo rm $PIDFILE

# through service
sudo systemctl stop suricata.service
sudo systemctl status suricata.service