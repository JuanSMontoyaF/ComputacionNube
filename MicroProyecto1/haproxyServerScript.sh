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


echo “[configuración contenedor de haproxy]”
echo "Creando contenedor de haproxy >> haproxy"
sudo lxc launch ubuntu:20.04 haproxy --target haproxy
sleep 20

echo "Runing instances"
sudo lxc start haproxy

echo "Aplicando un limite de memoria a los contenedores"
sudo lxc config set haproxy limits.memory 64MB


echo "Instalando Haproxy"
sudo lxc exec haproxy -- apt-get update
sudo lxc exec haproxy apt-get install haproxy -y

echo "Configurando Haproxy"
sudo lxc file rm /etc/haproxy/haproxy.cfg
sudo lxc file push /vagrant/haproxy.cfg /etc/haproxy/

echo "Reinicio de los servicios"
sudo lxc exec haproxy -- systemctl restart haproxy

sudo lxc haproxy touch 503.http /etc/haproxy/errors/503.http
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
