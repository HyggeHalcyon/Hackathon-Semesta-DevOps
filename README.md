# Hackthon-Semesta-DevOps
This repository contains my solution for the Semesta Scholarship System Administrator Hackathon. The event consist of 2 Task, one mandatory and and the second task can be chosen out of 2 choices.  
    
<br />    
    
## Cisco Packet Tracer   
This is the mandatory task. The **`.pkt`** file is accessible under the appropriate directory.    
Steps taken:      
1. VLAN on Core1 and Core2 ✅     
2. VTP Server and trunk port on Core1 and Core2 ✅       
3. VTP Client and trunk port on access switches ✅  
4. Port assignment on VLAN ✅   
5. STP on Core1 and Core2 ✅  
6. Etherchannel/Portchannel between Core1 and Core2 ✅     
7. HSRP on Core1 and Core2 ✅     
8. Configure Routing (OSPF) ❌      
9. Configure ACL to only allow access from LAN ❌    
        
<br />       
     
## IDS, IPS & Firewall Rules Automation    
The scripts of the second task falls under `2. Rules Automation` directory       
         
### ----- Install and Initialiazing   -----
to install suricata use the following command:    
`sudo ./init-suricata.sh <INTERFACE> <LAN ADDRESS> <LAN MASK>`              
to configure which interface or lan address that should be given as argument run the following `ip a s`     
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/ipas.png" style="height: 200px; aspect-ratio: auto;"/>     
and in my case because im running this on my VMWare it shall be:       
`sudo ./init-suricata.sh eth0 192.168.83.130 24`   
The script will:
- install suricata
- configure home network and interfaces
- configure and add custom and several open source rules
- test rules to be functional properly
- set a cron job to regularly update rules
- monitor logs in real time
*note that several distro might have different way of installation, I have provided it in the script but you still need to remove the comment yourself.*    

Next, configure IPTable to policy to NFQUEUE using the following script `iptable-suricata.sh`   
To run and stop suricata simply use the following script `./start-suricata` and `./stop-suricata.sh`  
    
### ----- Adding new Rules -----
It is recommended to add rules before you install suricata and the rules shall be applicable instantly, however if you wish to add new rules after suricata has been installed you can simply add your desired custom rules in the file `Suricata/config/local.rules`    

the syntax of rules signatures must abide the following order:            
- syntax   : `<ACTION> <PROTOCOL> <SOURCE IP> <SOURCE PORT> -> <DESTINATION IP> <DESTINATION PORT> <OPTIONS>`      
- example  : ` alert       ssh        any         any      ->      any                 !22       (msg: "ALERT")`    

after it is done, the cron job will automatically updates the rules on its excecution. However if you wish update the rules on the spot, simply run the  `update-rules-suricata-.sh` script.

### ----- Simulation and testing attacks -----
for demonstration and simple testing purposes, use `./NIDS-attack-sruicata.sh` script.   
it will simulate three attacks against our configured rules.    
1. it will curl testmynids.org that will deliberately alert one of the open source *emerging threat* rules    
2. it will try to ping 1.1.1.1 which alerts us according to our custom rules, this will test its IDS system    
3. it will try to ping 8.8.8.8 which according to our custom rules, it will drop it, this will test its IPS system

The following image shows the attack simulation without suricata nor firewall active     
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/ipas.png" style="height: 200px; aspect-ratio: auto;"/> 
     
First, we will configure our firewall configuration     
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/enable%20firewall%20config.png" alt="running firewall configuration script" style="height: 100px; aspect-ratio: auto;"/>    
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/making%20sure%20firewall%20config.png" alt="making sure configuration is correct" style="height:200px; aspect-ratio: auto;"/>    
       
Next, we'll configure our suricata while also actively monitoring the logs     
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/starting%20suricata.png" alt="starting suricata" style="height: 100px; aspect-ratio: auto;"/>    
       
Now its all done, we will try and simulate the attacks once again      
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/simulating%20attack.png" alt="simulating attack" style="height: 200px; aspect-ratio: auto;"/>    
        
Now as we can see the suricata have succesfully captured and take actions towards those traffic as we can see from the logs. It has succesfully implement the *emerging threats* rules as well alerting and blocking traffic.      
<img src="https://github.com/HyggeHalcyon/Hackathon-Semesta-DevOps/blob/main/Assets/suricata%20working%20.png" alt="simulating attack" style="height: 200px; aspect-ratio: auto;"/>    
