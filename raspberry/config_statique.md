# Configuration statique des dns, ip etc
## Explications

Avec Raspberry OS, la configuration de /etc/resolv.conf se fait automatiquement

## Configuration statique IP

La configuration ip statique se fait dans le fichier /etc/dhcpcd.conf :

```bash

vim /etc/dhcpcd.conf

# A sample configuration for dhcpcd.
# See dhcpcd.conf(5) for details.

...

# Example static IP configuration:
interface eth0
static ip_address=172.16.0.1/16
static routers=172.16.0.254
static domain_name_servers=127.0.0.1 8.8.8.8
static domain_name="d0cs1s.home"
static domain_search="d0cs1s.home"

...
```

## Configuration statique DNS

/etc/resolv.conf ne récupère pas la configuration dns. Pour la prendre en compte, créer le fichier /etc/resolv.conf.head et le peupler de la manière suivante :

```bash
vim /etc/resolv.conf.head

nameserver 127.0.0.1
nameserver 8.8.8.8
domain "d0cs1s.home"
```

## Vérifications

Reboot du Raspberry puis vérification du fichier /etc/resolv.conf.

Tests avec les commandes dig et nslookup
