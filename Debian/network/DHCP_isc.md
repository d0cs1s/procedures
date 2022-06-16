# Serveur DHCP isc
## Installation

### Serveur DHCP

Installer le paquet *isc-dhcp-server*

| Nom du paquet   | Fichiers de conf             | Fichier de baux           | Fichier journal |
| :-------------- | :--------------------------- | :------------------------ | :-------------- |
| isc-dhcp-server | /etc/default/isc-dhcp-server | /var/lib/dhcp/dhcp.leases | /var/log/syslog |
|                 | /etc/dhcp/dhcp.conf          |                           |                 |

### Serveur DHCP relay

- Installer le paquet *isc-dhcp-relay*
- Passer la configuration à moins de déjà connaître les informations à renseigner

## Configuration serveur DHCP

### Interface(s) à l'écoute

Dans le fichier de configuration globale, il faut spécifier ce quelle(s) interface(s) le service est à l'écoute :

```bash
nano /etc/default/isc-dhcp-server

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
