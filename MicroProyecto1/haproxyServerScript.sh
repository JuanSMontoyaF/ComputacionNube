#!/bin/bash

sudo apt-get update

echo "Instalamos LXD"
sudo apt-get install lxd -y


echo "Adicionar usuario al pool del cluster"
sudo gpasswd -a vagrant lxd

echo "Iniciando LXD"
sed -i "28d" /vagrant/preseed.yaml
sudo echo  "  core.https_address: 192.168.50.2:8443" >> /vagrant/preseed.yaml
cat /vagrant/preseed.yaml | lxd init --preseed
sleep 50
echo "Fin de la creación del cluster"



echo "Instalando Haproxy"
sudo apt-get update
sudo apt-get install net-tools -y
sudo apt-get install  haproxy -y

echo "Configurando Haproxy"
sudo rm /etc/haproxy/haproxy.cfg
sudo cp -f /vagrant/haproxy.cfg /etc/haproxy/

echo "Reinicio de los servicios"
sudo service haproxy restart 
sudo apt-get install -y apache2

sudo touch 503.http /etc/haproxy/errors/503.http
cat <<TEST> /etc/haproxy/errors/503.http
HTTP/1.0 503 Service Unavailable
Cache-Control: no-cache
Connection: close
Content-Type: text/html

<!DOCTYPE html>
<html>
<body>
<h1>Lo sentimos mucho, los servidores estan desconectados </h1>
<p>Vuelva pronto</p>
</body>
</html>
TEST
