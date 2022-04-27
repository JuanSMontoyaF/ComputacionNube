# Intalación 
El proyecto consta de tres maquinas virtuales
* Maquina1 con la IP 192.168.100.3
* Maquina2 con la IP 192.168.100.4
* Maquina3 con la IP 192.168.100.5

## Maquina1
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
sudo lxd launch ubuntu:18.04 nodo1 
````




## Maquina2
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
 # core.https_address: 192.168.100.4:8443
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
  #server_name: maquina2
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
sudo lxd launch ubuntu:18.04 nodo2 --target maquina2
````
Instalar apache 
````
sudo lxc exec nodo2 -- apt-get install apache2 -y
````
### Modificar el index.html
Entrar al contenedor 
````
lxc exec nodo2 /bin/bash
vim /var/wwww/html/index.html
````

````
<!DOCTYPE html>
<html>
<body>
<h1>Paágina de Prueba de Clúster con containers LXD</h1>
<p>Bienvenidos a mi contenedor LXD</p>
<p>Hostname: 192.168.100.4</p>
<p>Probando el funcionamiento del container con aprovisionamiento</p>
</body>
</html>
````


## Maquina3
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
 # core.https_address: 192.168.100.5:8443
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
  #server_name: maquina3
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
sudo lxd launch ubuntu:18.04 nodo3 --target maquina3
````
Instalar apache 
````
sudo lxc exec nodo3 -- apt-get install apache2 -y
````
### Modificar el index.html
Entrar al contenedor 
````
lxc exec nodo2 /bin/bash
vim /var/wwww/html/index.html
````

````
<!DOCTYPE html>
<html>
<body>
<h1>Página de Prueba de Clúster con containers LXD</h1>
<p>Bienvenidos a mi contenedor LXD</p>
<p>Hostname: 192.168.100.5</p>
<p>Probando el funcionamiento del container con aprovisionamiento</p>
</body>
</html>
````
