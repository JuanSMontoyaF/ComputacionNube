# Práctica LXD (Linux Containers)

### Comenzamos por agregar el vagrantfile

![](https://i.imgur.com/XBDrYar.png)

## Instalación LXD
````
sudo apt-get install lxd -y
````
### Luego ejecute el siguiente comando para loguearse en el nuevo grupo creado:
````
newgrp lxd
````

### Iniciar LXD
````
lxd init --auto
````
![](https://i.imgur.com/XBDrYar.png)

# Configuración del contenedor
### Se crea un contenedor con el nombre server
````
lxc launch ubuntu:20.04 server
````
### listar contenedores
````
lxc list
````
![imagen1](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen1.png)

### Detalles del estado de ejecucuón 
````
lxc info server
lxc config show server
````
![imagen2](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen2.png)

### Limitar los recursos
```
lxc config set server limits.memory 64MB
lxc exec server -- free -m
```
![imagen3](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen3.png)

![](https://i.imgur.com/XBDrYar.png)

# Configuración servidor Web Apache
````
lxc launch ubuntu:20.04 server
````

### instalar apache
````
lxc exec server -- apt-get install apache2 -y
````

### Verificar el estado del servicio
````
lxc exec server -- systemctl status apache2
````

![imagen4](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen4.png)

### Verificar la existencia del index
````
lxc exec server -- ls /var/www/html
````

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
````
lxc file push index.html server/var/www/html/index.html
````

### Verificar su contenido
````
lxc exec server -- cat /var/www/html/index.html
````

![imagen5](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen5.png)

### Reiniciar el servicio
````
lxc exec server -- systemctl restart apache2
````

### Probar usando Curl
````
curl 10.216.201.122
````

![imagen6](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen6.png)

# Reenvio de puertos 
## Puerto 80
````
lxc config device add server myport80 proxy listen=tcp:192.168.100.3:5080 connect=tcp:127.0.0.1:80
````
## Puerto 22
````
lxc config device add server myport22 proxy listen=tcp:192.168.100.3:6080 connect=tcp:127.0.0.1:22
````

###Verificar los dispositivos creados
````
lxc config device show server
````

![imagen7](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen7.png)
### Compruebe el servicio por fuera de la maquina vagrant
![imagen8](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen8.png)

![](https://i.imgur.com/XBDrYar.png)

# Configuración Servidor SSH en el contenedor
### Habilitar autenticación por password en SSH en el contenedor
````
sudo lxc exec server bash
vim /etc/ssh/sshd_config
````

### Busque el parámetro PasswordAuthentication  y configúrelo como yes:
````
PasswordAuthentication yes
![imagen9](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen9.png)
````

### Se reinicia el servicio
````
service sshd restart
````

### Se añade un nuevo usuario en el contenedor
````
adduser remoto
````

### Salimos del contenedor
````
exit
````

verificamos el acceso con ssh
````
ssh remoto@10.216.201.122
````

![imagen10](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen10.png)

# Crear par de claves SSH 
````
ssh-keygen
````
![imagen11](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen11.png)

### Se copia la clave pública en el contenedor
````
ssh-copy-id remoto@10.216.201.122
````

![imagen12](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen12.png)

![](https://i.imgur.com/XBDrYar.png)

# DESDE EL CLIENTE
### Generar el par de claves
````
ssh-keygen
````

### Copiar la clave publica al contenedor 
````
ssh-copy-id -p 6080 remoto@192.168.100.3
````

### Iniciar sesión remotamente 
````
ssh -p 6080 remoto@192.168.100.3
````
![imagen13](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen13.png)

### Transferir un archivo al servidor usando scp
````
scp -P 6080 prueba2.txt remoto@192.168.100.3:~/
````
![imagen14](https://github.com/JuanSMontoyaF/ComputacionNube/blob/master/Practica2_LXD/imagenes/imagen14.png)





