# Installation et configuration de Squid
## Installation

```bash
apt install squid
```

### Vérification de l'installation 

```bash
systemctl status squid
```

> Le service démarre automatiquement

## Configuration de Squid

La configuration se fait dans les fichiers :

- /etc/squid/squid.conf
- /etc/

Pour voir le fichier débarassé de tous les commentaires et avec les numéros de ligne :

```bash
 grep -vEn “\^#|\^$” /etc/squid/squid.conf
 ```

Bonne pratique : avant modification des fichiers de configuration par défaut, en faire un backup.

Eclaircir le fichier par défaut afin de travailler dessus :

```bash
cd /etc/squid/ && cp squid.conf squid.conf.backup
grep -vE “^#|^$” /etc/squid/squid.conf.backup > squid.conf
```

### Modification du port par défaut

- Localiser la ligne "http_port 3128"
- Modifier le port comme voulu

### Autoriser le réseau local

Par défaut, Debian n'autorise que la connexion localhost. Il faut donc modifier le fichier /etc/squid/conf.d/debian.conf :

- Décommenter la ligne "http_access allow localnet"
