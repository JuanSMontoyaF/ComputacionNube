# Intalación 
El proyecto consta de tres maquinas virtuales
* haproxy con la IP 192.168.50.2
* webserver1 con la IP 192.168.50.3
* webserver2 con la IP 192.168.50.4

## haproxy
````
sudo apt-get update && upgrade -y
````
Intalación de lxd 
````
sudo apt-get install lxd -y
````
Adicionar usuario al pool del cluster
````
sudo gpasswd -a vagrant lxd
````
### Generar el cluster
Iniciar lxd
````
lxd init 
````
Configuración del cluster
````
#config:
 # core.https_address: 192.168.100.3:8443
 # core.trust_password: "cluster"
#networks:
#- config:
    #bridge.mode: fan
   # fan.underlay_subnet: auto
  #description: ""
  #name: lxdfan0
 # type: ""
#storage_pools:
#- config: {}
  #description: ""
  #name: local
 # driver: dir
#profiles:
#- config: {}
 # description: ""
  #devices:
    #eth0:
     # name: eth0
      #network: lxdfan0
     # type: nic
    #root:
    #  path: /
   #   pool: local
  #    type: disk
 # name: default
#cluster:
  #server_name: maquina1
  #enabled: true
  #member_config: []
  #cluster_address: ""
  #cluster_certificate: ""
  #server_address: ""
  #cluster_password: ""
 # cluster_certificate_path: ""
#  cluster_token: ""
````

### Crear el contenedor
````
sudo lxd launch ubuntu:18.04 haproxy
````




## webserver1
````
sudo apt-get update && upgrade -y
````
Intalación de lxd 
````
sudo apt-get install lxd -y
````
Adicionar usuario al pool del cluster
````
sudo gpasswd -a vagrant lxd
````
### Generar el cluster
Iniciar lxd
````
lxd init 
````
Configuración del cluster
````
#config:
 # core.https_address: 192.168.50.3:8443
 # core.trust_password: "cluster"
#networks:
#- config:
    #bridge.mode: fan
   # fan.underlay_subnet: auto
  #description: ""
  #name: lxdfan0
 # type: ""
#storage_pools:
#- config: {}
  #description: ""
  #name: local
 # driver: dir
#profiles:
#- config: {}
 # description: ""
  #devices:
    #eth0:
     # name: eth0
      #network: lxdfan0
     # type: nic
    #root:
    #  path: /
   #   pool: local
  #    type: disk
 # name: default
#cluster:
  #server_name: web1
  #enabled: true
  #member_config: []
  #cluster_address: ""
  #cluster_certificate: ""
  #server_address: ""
  #cluster_password: ""
 # cluster_certificate_path: ""
#  cluster_token: ""
````

### Crear el contenedor
````
sudo lxd launch ubuntu:18.04 web1 --target webserver1
````
Instalar apache 
````
sudo lxc exec web1 -- apt-get install apache2 -y
````
### Modificar el index.html
Entrar al contenedor 
````
lxc exec web1 /bin/bash
vim /var/wwww/html/index.html
````

````
<!DOCTYPE html>
<html>
<body>
<h1>Pagina de Prueba de Cluster con containers LXD</h1>
<p>Bienvenidos al contenedor LXD</p>
<p>Hostname: 192.168.50.3</p>
<p>Container con aprovisionamiento</p>
</body>
</html>
````


## webserver2
````
sudo apt-get update && upgrade -y
````
Intalación de lxd 
````
sudo apt-get install lxd -y
````
Adicionar usuario al pool del cluster
````
sudo gpasswd -a vagrant lxd
````
### Generar el cluster
Iniciar lxd
````
lxd init 
````
Configuración del cluster
````
#config:
 # core.https_address: 192.168.50.4:8443
 # core.trust_password: "cluster"
#networks:
#- config:
    #bridge.mode: fan
   # fan.underlay_subnet: auto
  #description: ""
  #name: lxdfan0
 # type: ""
#storage_pools:
#- config: {}
  #description: ""
  #name: local
 # driver: dir
#profiles:
#- config: {}
 # description: ""
  #devices:
    #eth0:
     # name: eth0
      #network: lxdfan0
     # type: nic
    #root:
    #  path: /
   #   pool: local
  #    type: disk
 # name: default
#cluster:
  #server_name: web2
  #enabled: true
  #member_config: []
  #cluster_address: ""
  #cluster_certificate: ""
  #server_address: ""
  #cluster_password: ""
 # cluster_certificate_path: ""
#  cluster_token: ""
````

### Crear el contenedor
````
sudo lxd launch ubuntu:18.04 web2 --target webserver2
````
Instalar apache 
````
sudo lxc exec web2 -- apt-get install apache2 -y
````
### Modificar el index.html
Entrar al contenedor 
````
lxc exec web2 /bin/bash
vim /var/wwww/html/index.html
````

````
<!DOCTYPE html>
<html>
<body>
<h1>Página de Prueba de Clúster con containers LXD</h1>
<p>Bienvenidos al contenedor LXD</p>
<p>Hostname: 192.168.50.4</p>
<p>Container con aprovisionamiento</p>
</body>
</html>
````
