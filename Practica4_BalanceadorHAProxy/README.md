# Balanceo de carga HAProxy

## Instalación de LXD 
````
sudo apt-get install lxd -y 
````
### Loguearse con un grupo creado 
````
newgrp lxd 
````
### inicializar lxd
````
lxd init --auto
````

## Intalación de servidores de backend corriendo apache
````
lxc launch ubuntu:18.04 web1
lxc lauch ubuntu:18.04 web2
````

# WEB 1
## Instalación de servidor apache 
### ingresar al Shell y ejecutar 
````
lxc exec web1 /bin/bash
````

### En root
````
apt update && apt upgrade -y
apt install apache2 -y
systemctl enable apache2
````
### Incluir en el contenido del index 
````
Hello from web 1
````
### iniciar el servidor Apache
````
vim /var/wwww/html/index.html
systemctl start apache2
````
### Probar el servidor apache 
````
curl 
````
# WEB2
### Realizar los pasos del web1


# Configurar contenedor HAProxy
````
lxc launch ubuntu:18.04 haproxy
````
### ingresar al Shell haproxy
````
lxc exec haproxy /bin/bash
````
### Ejecutar
````
apt update && apt upgrade -y
apt install haproxy -y
systemctl enable haproxy
````


