#!/bin/bash

sudo apt-get install net-tools -y
sudo apt-get update -y
sudo apt-get upgrade -y

echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "instalando un servidor vsftpd"
sudo apt-get install vsftpd -y
echo “Modificando vsftpd.conf con sed”
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
echo "configurando ip forwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "instalando jupyter"

sudo apt install python3-pip -y
pip3 install jupyter
pip3 install markupsafe==2.0.1
export PATH="$HOME/.local/bin:$PATH"
jupyter notebook --ip=0.0.0.0