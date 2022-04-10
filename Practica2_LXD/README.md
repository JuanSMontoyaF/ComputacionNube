# Práctica LXD (Linux Containers)

### Comenzamos por agregar el vagrantfile

![](https://i.imgur.com/XBDrYar.png)

## Instalación LXD
sudo apt-get install lxd -y

### Luego ejecute el siguiente comando para loguearse en el nuevo grupo creado:
newgrp lxd

### Iniciar LXD
lxd init --auto


# Configuración del contenedor
lxc launch ubuntu:20.04 server
### listar contenedores
lxc list
### Detalles del estado de ejecucuón 
lxc info server
lxc config show server

### Limitar los recursos
```
lxc config set server limits.memory 64MB
lxc exec server -- free -m
```


# Configuración servidor Web Apache
lxc launch ubuntu:20.04 server

### instalar apache
lxc exec server -- apt-get install apache2

### Verificar el estado del servicio
lxc exec web -- systemctl status apache2

### Verificar la existencia del index
lxc exec web -- ls /var/www/html

### Crear un nuevo index fuera del contenedor
```
<!DOCTYPE html>
<html>
<body>
<h1>Pagina de prueba</h1>
<p>Bienvenidos a mi contenedor LXD</p>
</body>
</html>
```
### Reemplazar el index en el contenedor
lxc file push index.html web/var/www/html/index.html

### Verificar su contenido
vagrant@servidorUbuntu:~$ lxc exec web -- cat /var/www/html/index.html

### Reiniciar el servicio
lxc exec web -- systemctl restart apache2

### Verificar la ip del contenedor 
lxc info web

### Probar usando Curl
curl 10.24.66.4

# Reenvio de puertos 
## Puerto 80
lxc config device add server myport80 proxy listen=tcp:192.168.100.3:5080 connect=tcp:127.0.0.1:80
## Puerto 22
lxc config device add server myport22 proxy listen=tcp:192.168.100.3:6080 connect=tcp:127.0.0.1:22

###Verificar los dispositivos creados
lxc config device show web


