# Serveur DHCP isc
## Installation

### Serveur DHCP

Installer le paquet *isc-dhcp-server*

| Nom du paquet   | Fichiers de conf             | Fichier de baux           | Fichier journal |
| :-------------- | :--------------------------- | :------------------------ | :-------------- |
| isc-dhcp-server | /etc/default/isc-dhcp-server | /var/lib/dhcp/dhcp.leases | /var/log/syslog |
|                 | /etc/dhcp/dhcpd.conf         |                           |                 |

### Serveur DHCP relay

- Installer le paquet *isc-dhcp-relay*
- Passer la configuration à moins de déjà connaître les informations à renseigner

## Configuration serveur DHCP

### Interface(s) à l'écoute

Dans le fichier de configuration globale, il faut spécifier ce quelle(s) interface(s) le service est à l'écoute :

```bash
nano /etc/default/isc-dhcp-server

...
On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACESv4="ens33"
INTERFACESv6=""
```

Passons à la configuration du service : /etc/dhcp/dhcpd.conf

```bash
nano /etc/dhcp/dhcpd.conf
...
# Serveur DNS du réseau
option domain-name "masuperzone.local"
option domain-name-servers 192.168.9.12;
...
# Lease time en secondes
default-lease-time 345600;
max-lease-time 691200;
...
# If this DHCP server is the official DHCP server for the local
# network, the authoritative directive should be uncommented.
authoritative;
...
# No service will be given on this subnet, but declaring it helps the 
# DHCP server to understand the network topology.

subnet 192.168.9.0 netmask 255.255.255.0 {
}

# This is a very basic subnet declaration.
# On ajoute ici le réseau que va gérer le DHCP

subnet 172.18.9.0 netmask 255.255.255.0 {
  range 172.18.9.100 172.18.9.200;
  option routers 192.168.9.254;
}
...
# Pour ajouter une réservation
host hote-fixe {
 hardware ethernet 00:00:00:5e:13:37;
 fixed-address 172.18.9.105;
}
```

## Configuration serveur DHCP Relay

Déterminer les interfaces sur lesquelles doit écouter le server DHCP Relay

1ere option :

```bash
dpkg-reconfigure isc-dhcp-relay
```
Répondre aux questions de l'assistant.

2è option : passer par le fichier de configuration

```bash
nano /etc/default/isc-dhcp-relay

 Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.168.9.11"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="ens33 ens36"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
```
> Redémarrer le service après configuration

## Troubleshooting

En cas d'incident, il est possible de lancer les services au 1er plan grâce au mode débug et ainsi voir ce qui ne va pas. 

Pour lancer dhcp server en mode débug :

```bash
systemctl stop isc-dhcp-server
dhcpd -d
```

Pour lancer le relay en mode débug :

```bash
dhcrelay -d -id <interfacedownstream> -iu <interfaceupstream> <serveurDHCPajoindre>
```

> Il faut reboot la machine après un lancement en mode debug ou rm /var/run/dhcpd.pid
