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

### Sécurisation d'apache2

Modifier le fichier de configuration /etc/apache2/mods-enabled/dir.conf : 
```
<IfModule mod_dir.c>
  DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
</IfModule>
```
Quand apache2 cherche la page d'index du site, il commence par chercher index.html puis index.cgi etc. Si vos sites n'utilisent que index.php, enlever les autres types de fichiers.
Ceci afin d'empêcher un attaquant d'envoyer et de faire afficher un fichier index.html par exemple

## Configuration d'un nouveau site

La configuration se trouve dans /etc/apache2/sites-available.

On va travailler sur un exemple, le site intranet.d0cs1s.lcl : 

- Créer un nouveau fichier de configuration pour le nouveau site. On nommera ce fichier intranet.d0cs1s.lcl.conf
- Voici un exemple de configuration :
```
<VirtualHost *:80>
  DocumentRoot /var/www/intranet.d0cs1s.lcl # On créera le dossier plus tard
  ServerName intranet.d0cs1s.lcl
  <Directory /var/www/intranet.d0cs1s.lcl>
    Options Multiviews
    AllowOverride None # Pour désactiver le .htaccess
    Require all granted
  </Directory>
</VirtualHost>
```
- Créer le dossier du site web dans /var/www/, ici il faudra bien nommer le dossier intranet.d0cs1s.lcl
- Importer le site à l'intérieur de ce dossier

note : Dans cette configuration, on déclare notre site web par FQDN avec la mention ServerName. Il est aussi possible de la faire par ip ou par port.

#### Gestion des droits et utilisateurs

Afin de sécuriser l'infrastructure, on va créer un utilisateur par site. Changer les propriétaires et les droits. Procéder comme suivant :

- Création du compte utilisateur pour le site et ajout de www-data au groupe du user nouvellement créé : 
```bash
useradd -s /bin/false -d /var/www/intranet.d0cs1s.lcl intranet
usermod -aG intranet www-data
```

- Changement des permissions des fichiers et dossiers du site :
```bash
cd /var/www/
find . -type d -exec chmod 2770 {} \;
find . -type f -exec chmod 660 {} \;
```

#### Ajout au DNS

Il ne faut pas oublier de rajouter un champ A au DNS

intranet  A <ip_du_serveur_web>
