#!/bin/bash

# The IDS functionality will be tested with a signature ID of 2100498 
# by sending an HTTP request to the testmynids.org website which is a 
# NIDS (Network Intrusion and Detection System) framework.

curl --max-time 5 http://testmynids.org/uid/index.html
ping -c 3 8.8.8.8
ping -c 3 1.1.1.1