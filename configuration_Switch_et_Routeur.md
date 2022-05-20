# Configuration d'un réseau Cisco
## Configuration d'un switch
### Configuration de base

Passer en mode d'administration avec :
```
enable
```

Passer en mode configuration :

```
conf t
```

Définir un nom d'hôte :
```
hostname [nom]
```

### Sécurisation du switch et des accès 
#### Sécurisation

Sécurisation de l'accès au mode d'exécution utilisateur :
```
line console 0
password [motdepase]
login
```

Sécurisation de l'accès au mode d'exécution privilégié :
```
enable secret [motdepasse]
```

Sécurisation de l'accès des lignes vty 0 à 15 :
```
conf t
line vty 0 15
password [motdepasse]
login
```

Chiffrement des mots de passes créés et à venir :
```
conf t
service password-encryption
security password min-length 10
```

Désactivation de la commande de recherche DNS :
```
no ip domain-lookup
```
#### Accès ssh

Définition du domaine :
```
ip domain-name [mondomaine.com]
```

Génération des paires de clés RSA :
```
crypto key generate RSA
```

Création d'un utilisateur :
```
username [utilisateur] secret [password]
```

Activation du protocol ssh sur les lignes vty en mode configuration :
```
line vty 0 15
transport input ssh
login local
```

Blocage de l'accès pendant une durée définie après plusieurs tentatives :
```
login block-for [secondes] attemps [nb_d'essais] within [secondes]
exemple :
login block-for 180 attemps 4 within 120
bloque pendant 3 minutes toutes personnes qui ne se connecte pas après 4 tentatives dans un délai de 2 minutes
```

Réglage du timeout du mode EXEC sur les ligne vty :
```
line vty 0 15
exec-timeout [minutes]
```

Création d'un motd :
En mode config
```
banner motd "Le Message Of The Day : Authorized access only"
```

Enregistrement de la configuration :
```
copy running-config startup-config
```

### Création des VLANs


Passer en mode configuration :

```
conf t
```

Création des VLANs :

```
vlan 10
name NomDuVLAN
exit
```

Assignation des VLANs aux interfaces :

```
S1(config)#interface F0/11
S1(config-if)#switchport mode access
S1(config-if)#switchport access vlan 10
S1(config-if)#exit
```

Vérification : 

```
S1#show vlan brief
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Fa0/1, Fa0/2, Fa0/3, Fa0/4
                                                Fa0/5, Fa0/7, Fa0/8, Fa0/9
                                                Fa0/10, Fa0/12, Fa0/13, Fa0/14
                                                Fa0/15, Fa0/16, Fa0/17, Fa0/18
                                                Fa0/19, Fa0/20, Fa0/21, Fa0/22
                                                Fa0/23, Fa0/24, Gig0/1, Gig0/2
10   VLAN0010                         active    Fa0/11
30   VLAN0030                         active    Fa0/6
```

VLAN de données et de voix avec QoS :
```
conf t
vlan [Vlan-ID] //exemple : 10
name [Vlan-Name]
vlan [Vlan-ID] //exemple : 150
name VOICE
exit
interface [int-ID]
switchport mode access
switchport access vlan [Vlan-ID:10]
mls qos trust cos
switchport voice vlan [Vlan-ID:150]
end
```

La ligne "mls qos trust cos" signifie qu'on active le multilayer switching avec du QoS faisant confiance à ce que l'équipement lui transmet comme information.
Vérifier la configuration avec :
```
show vlan brief
```

### Configuration d'un trunk

```
S1(config)#interface G0/1
S1(config-if)#switchport mode trunk
S1(config-if)#switchport trunk native vlan 99
S1(config-if)#switchport trunk allowed vlan 10,30,99,150
S1(config-if)#end
```

### Configuration de l'accès à distance sécurisé (ssh)


## Configuration d'un routeur
### Configuration de base

La procédure de configuration de base du routeur est la même que pour le switch.
Attention : les interfaces ne sont pas activées par défaut sur le routeur. 

Activer une interface :
```
conf t
interface [interface]
no shutdown
```
Configurer une adresse IP sur une interface :
```
ip address [IP] [subnet-mask]
```

### Routage statique

Création de la route par défaut :
```
ip route 0.0.0.0 0.0.0.0 192.168.1.1
```

Création d'une route statique :
```
ip route [network] [mask] [ip_interface]
```
Pour atteindre le réseau [network] passer par [ip_interface]

### Routage Inter-VLAN (router on a sitck)

Création de la sous-interface G0/0.10 et de la sous-interface G0/0.30

```
R1(config)#interface G0/0.10
R1(config-subif)#encapsulation dot1Q 10
R1(config-subif)#ip address 172.17.10.1 255.255.255.0
R1(config-subif)#exit
R1(config)#interface G0/0.30
R1(config-subif)#encapsulation dot1Q 30
R1(config-subif)#ip address 172.17.30.1 255.255.255.0
```

Vérification : 

```
R1#show ip interface brief 
Interface              IP-Address      OK? Method Status                Protocol 
GigabitEthernet0/0     unassigned      YES unset  administratively down down 
GigabitEthernet0/0.10  172.17.10.1     YES manual administratively down down 
GigabitEthernet0/0.30  172.17.30.1     YES manual administratively down down 
GigabitEthernet0/1     unassigned      YES unset  administratively down down 
Vlan1                  unassigned      YES unset  administratively down down
```

Activer l'intergace G0/0 :

```
R1(config)#interface G0/0
R1(config-if)#no shutdown
```
