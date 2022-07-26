# Serveur web Apache
## Installation du service apache2

```bash
apt install apache2
```

Vérification du service :

```bash
systemctl status apache2.service
```

## Configuration d'apache2

### Localisation des fichiers

- /etc/apache2/apache2.conf : fichier de configuration principal
- /etc/apache2/ports.conf : Pour configurer les ports d'écoute du service
- /etc/apache2/mods-enabled/ : dossier de configuration de modules
- /etc/apache2/conf-enabled/ : dossier de configuration divers
- /etc/apache2/sites-enabled/ : dossier de configuration des virtual host
- /var/www/html/ : dossier racine par défaut du service web

