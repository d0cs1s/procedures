# Configuration réseau sans GUI
## Localisation des fichiers
### Debian Serveur

- service: networking
- fichier: /etc/network/interfaces
- dns: /etc/resolv.conf
- hostname: /etc/hosts et /etc/hostname
- changer ordre de resolution des noms: /etc/nsswitch.conf

Ne pas oublier après des changements de configuration : 
```bash
systemctl restart networking.service
```

## Configuration

### IP

Dans le fichier /etc/network/interfaces.

exemple de configuration :
```bash
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto ens33
iface ens33 inet static
  address 172.16.0.1/16
  gateway 172.16.0.254
```

### Nom d'hôte

Pour modifier le nom d'hôte, il faut le modifier dans le fichier /etc/hostname.

Dans le cas d'un nom FQDN, il faut pouvoir résoudre ce nom localement et donc l'ajouter au fichier /etc/hosts comme-ci dessous :

```
127.0.0.1    localhost
127.0.1.1    nomfqdn.exemple.net
```

Par défaut, la machine va vérifier son cache DNS local avant d'aller vérifier sur le serveur DNS. Il est possible de modifier l'ordre de résolution en modifiant le fichier suivant : /etc/nsswitch.conf

```shell
grep hosts /etc/nsswitch.conf
hosts: files dns
```
> Pour demander directement au serveur DNS, faire passer *dns* devant *files*

### Ip forwarding

Linux sait router les paquets qui lui sont remis mais ne lui sont pas destinés.

Pour modifier durablement l'état d'activation du routage, il faut modifier le fichier suivant : /etc/sysctl.conf

Il faut pour cela décommenter la ligne suivante :

```bash 
net.ipv4.ip_forward = 1
```
> avec l'option à 0, le routage sera inactif

Pour forcer la prise en compte immédiate du forwarding :

```bash
sysctl -p
```
