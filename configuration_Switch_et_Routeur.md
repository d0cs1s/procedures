# Configuration d'un réseau Cisco
## Configuration d'un switch
### Création des VLANs

Passer en mode *enable*

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

### Configuration d'un trunk

```
S1(config)#interface G0/1
S1(config-if)#switchport mode trunk
S1(config-if)#switchport trunk native vlan 99
S1(config-if)#switchport trunk allowed vlan 10,30,99
S1(config-if)#end
```


## Configuration d'un routeur
### Configuration des sous-interfaces (router on a stick)

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