# Hackthon-Semesta-DevOps
This repository contains my solution for the Semesta Scholarship System Administrator Hackathon. The event consist of 2 Task, one mandatory and and the second task can be chosen out of 2 choices.  

<br />

## Cisco Packet Tracer   
This is the mandatory task. The **`.pkt`** file is accessible under the appropriate directory.
     
<br />

## IDS, IPS & Firewall Rules Automation    
The scripts of the second task falls under `2. Rules Automation` directory       
         
### ----- Install and Initialiazing   -----
to install suricata use the following command:    
`sudo ./init-suricata.sh <INTERFACE> <LAN ADDRESS> <LAN MASK>`              
to configure which interface or lan address that should be given as argument run the following   
`ip a s`

and because im simply running this on my VM it shall be:     
`sudo ./init-suricata.sh eth0 192.168.83.130 24`
The script will:
- install suricata
- configure home network and interfaces
- configure and add custom and several open source rules
- test rules to be functional properly
- set a cron job to regularly update rules    
*note that several distro might have different way of installation, I have provided it in the script but you still need to remove the comment yourself.*    

Next, configure IPTable to policy to NFQUEUE using the following script `iptable-suricata.sh`   
To run and stop suricata simply use the following script `./start-suricata` and `./stop-suricata.sh`  
    
### ----- Adding new Rules -----
It is recommended to add rules before you install suricata and the rules shall be applicable instantly, however if you wish to add new rules after suricata has been installed you can simply add your desired custom rules in the file `Suricata/config/local.rules`    

the syntax of rules signatures must abide the following order:            
- syntax   : `<ACTION> <PROTOCOL> <SOURCE IP> <SOURCE PORT> -> <DESTINATION IP> <DESTINATION PORT> <OPTIONS>`      
- example  : ` alert       ssh        any         any      ->      any                 !22         (msg: "NON-SSH traffic in SSH Port")`    

after it is done, the cron job will automatically updates the rules on its excecution. However if you wish update the rules on the spot, simply run the  `update-rules-suricata-.sh` script.

### ----- Simulation and testing attacks -----
for demonstration and simple testing purposes, use `./NIDS-attack-sruicata.sh` script.

the attack is simulated using the following tool:
[testmydnis](https://github.com/3CORESec/testmynids.org)