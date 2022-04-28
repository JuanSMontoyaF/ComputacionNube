#!/bin/bash
echo "Hostname: >> $2"
echo "Instalando Paquetes"
sudo apt update
sudo apt-get install net-tools
sudo apt-get install -y apache2
#sudo echo "Hostname:$1 IP:$2" >> /var/www/index.html

#Instalacion del contenedor

echo "Instalamos LXD"
sudo apt-get install lxd -y
#sudo aptitude install lxc lxc-templates
#sudo apt install zfsutils-linux lxd -y

echo "Adicionar usuario al pool del cluster"
#sudo gpasswd -a vagrant lxd

echo "Iniciando LXD"
sed -i "28d" /vagrant/preseed.yaml
sudo echo  "  core.https_address: $2:8443" >> /vagrant/preseed.yaml
cat /vagrant/preseed.yaml | lxd init --preseed
sleep 50
echo "Fin de la creación del cluster"

echo “[configuración contenedor de backup]”

echo "Creando contenedor de backup$1 >> webserver$1"
sudo lxc launch ubuntu:20.04 webbackup$1 --target webserver$1
sleep 20

echo "Runing instances"
sudo lxc start webbackup$1

echo "Aplicando un limite de memoria a los contenedores"
sudo lxc config set webbackup$1 limits.memory 64MB

echo "Instalando Apache"
sudo lxc exec webbackup$1 -- apt-get update
sudo lxc exec webbackup$1 -- apt-get install apache2 -y
sudo touch index.html /var/www/html

cat <<TEST> /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>
<h1>Pagina de Prueba de Cluster con containers LXD</h1>
<p>Bienvenidos al contenedor webbackup$1</p>
<p>Hostname:$1 IP:$2</p>
<p>Container con aprovisionamiento</p>
</body>
</html>
TEST

echo "Reemplazar archivo"
lxc file push /var/www/html/index.html webbackup$1/var/www/html/index.html

echo "Reincio del servicio apache"
lxc exec webbackup$1 -- systemctl restart apache2

echo "Reenvio de puertos"
lxc config device add webbackup$1 myport80 proxy listen=tcp:$2:6080 connect=tcp:127.0.0.1:80

echo "Creando contenedor web$1 >> webserver$1"
sudo lxc launch ubuntu:20.04 web$1 --target webserver$1
sleep 20

echo "Aplicar un limite de memoria a los contenedores"
sudo lxc config set web$1 limits.memory 64MB

echo "Runing instances"
sudo lxc start web$1

echo “[configuración contenedor web]”
echo "Instalando Apache"
sudo lxc exec web$1 -- apt-get update
sudo lxc exec web$1 -- apt-get install apache2 -y
sudo touch index.html /var/www/html

cat <<TEST> /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>
<h1>Pagina de Prueba de Cluster con containers LXD</h1>
<p>Bienvenidos al contenedor WEB$1</p>
<p>Hostname:$1 IP:$2</p>
<p>Container con aprovisionamiento</p>
</body>
</html>
TEST

echo "Reemplazar archivo"
lxc file push /var/www/html/index.html web$1/var/www/html/index.html

echo "Reincio del servicio apache"
lxc exec web$1 -- systemctl restart apache2

echo "Reenvio de puertos"
lxc config device add web$1 myport80 proxy listen=tcp:$2:5080 connect=tcp:127.0.0.1:80
