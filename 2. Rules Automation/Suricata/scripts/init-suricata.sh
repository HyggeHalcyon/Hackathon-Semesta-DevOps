#!/bin/bash

# assign config variables
INTERFACE=$1
LOCALNET_ADDR=$2
LOCALNET_MASK=$3
LOCALNET=${LOCALNET_ADDR}/${LOCALNET_MASK}

config_check(){
    if [ -z "$LOCALNET_ADDR" ] || [ -z "$LOCALNET_MASK" ] || [ -z "$INTERFACE" ]; then 
        echo "[!]Usage   :  ./init-suricata.sh <INTERFACE> <LAN ADDRESS> <LAN MASK>"
        echo "[!]Example :  ./init-suricaata.sh   eth0      192.168.1.1      24"
        exit 1
    fi
}

root_check(){
	if [[ $EUID -ne 0 ]]; 
    then echo "[!] script needs root priviledge"; exit 1
	fi
}

install(){
    # install suricata on Kali-Linux
    sudo apt -y install suricata

    # install suricata on Ubuntu
    # sudo apt-get install software-properties-common
    # sudo add-apt-repository ppa:oisf/suricata-stable
    # sudo apt-get update
    # sudo apt install suricata

    # install suricata on Fedora
    # sudo dnf install 'dnf-command(copr)'
    # sudo dnf copr enable @oisf/suricata-6.0
    # sudo dnf install epel-release
    # sudo dnf install suricata

    # stop incase it is running
    sudo systemctl stop suricata

    # set suricata to IPS mode
    sudo mv ../config/suricata /etc/default/suricata

    # backup & config suricata
	sudo mv /etc/suricata/suricata.yaml /etc/suricata/suricata.yaml.bak
    sudo cp ../config/suricata.yaml /etc/suricata/suricata.yaml
    sudo cp ../config/local.rules /etc/suricata/rules
    sudo sed -i "s/interface: eth0/interface: $INTERFACE/" /etc/suricata/suricata.yaml
    sudo sed -i "s/HOME_NET:.*$/HOME_NET: "$LOCALNET_ADDR"/" /etc/suricata/suricata.yaml

    # configure suricata custom rule ip with home network given in arguments
    sudo sed -i "s/HOME_NET$/$LOCALNET_ADDR/" /etc/suricata/suricata.yaml
    
    # add open-source rules 
    sudo suricata-update enable-source et/open
    sudo suricata-update enable-source oisf/trafficid
    sudo suricata-update enable-source tgreen/hunting

    # add local rules
    sudo suricata-update -o /etc/suricata/rules
    sudo suricata-update -o /var/lib/suricata/rules/

    # test suricata if suricata rules are functional properly
    sudo suricata -T -c /etc/suricata/suricata.yaml -v

    # set cron job to regularly update rules
    daily='@daily "/path/to/update-rules-suricata.sh"'
    crontab -l > tempcron
    if ! grep -q "$daily" tempcron; then
        echo $daily >> tempcron
        crontab tempcron
    fi
    rm tempcron

    # enable on startup
    sudo systemctl enable suricata

    # display information
    suricata -V
    sudo systemctl status suricata
}

main(){
    # check if variables is assigned (not NULL)
    config_check

    # check for root priviledges
    root_check

    # install suricata
    install
}

main