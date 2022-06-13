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

### Ip forwarding

Linux sait router les paquets qui lui sont remis mais ne lui sont pas destinés.

Pour modifier durablement l'état d'activation du routage, il faut modifier le fichier suivant : /etc/sysctl.conf

Il faut pour cela décommenter la ligne suivante :

```bash 
net.ipv4.ip_forward = 1
```
