# GLPI
## Prérequis

- Debian 10 ou 11
- Apache2
- php7.3 ou php7.4 (php7.4 sur Debian 11)
- MariaDB-server
- php-apcu-bc
- php-cas

### Installation des prérequis

Pour Debian 10 :

```bash
apt install apache2 php7.3 php7.3-mysql php7.3-mbstring php7.3-curl php7.3-gb php7.3-xml php7.3-ldap php7.3-xmlrpc php7.3-imap php7.3-intl php7.3-zip php7.3-bz2 mariadb-server php-apcu-bc php-cas
```

Pour Debian 11 : 

```bash
apt install apache2 php7.4 php7.4-mysql php7.4-mbstring php7.4-curl php7.4-gb php7.4-xml php7.4-ldap php7.4-xmlrpc php7.4-imap php7.4-intl php7.4-zip php7.4-bz2 mariadb-server php-apcu-bc php-cas
```

## Configuration de la base de données

```bash
mysql_secure_installation

Change the root password? Y # Entrer un nouveau mot de passe
Remove anonymous users? Y
Disallow root login remotely? Y
Remove test database and anccess to it? [Y/n]
Reload privilege tables now? Y
```

Se connecter à mariaDB et créer une base de données pour glpi :

```bash
mysql -u root -p
Mysql> CREATE DATABASE glpidb;
```

Créer un nouvel utilisateur pour la bdd : 

```bash
Mysql> CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'motdepassecomplexe';
Mysql> GRANT ALL PRIVILEGES ON glpidb.* TO glpi@localhost IDENTIFIED BY 'motdepassecomplexe';
```

Vérification des droits pour pour l'utilisateur glpi :

```bash
Mysql> SHOW GRANTS FOR glpi@localhost;
```

## Installation de GLPI

### Préparation des dossiers

GLPI va nécessiter la création de plusieurs répertoire :

- /etc/glpi
- /var/www/glpi.mondomain.tld
- /var/lib/glpi
- /var/log/glpi

```bash
mkdir -p /etc/glpi,/var/{lib/glpi,log/glpi,www/glpi.mondomain.tlk}
```

Créer un utilisateur pour glpi, changer le propriétaire des dossiers et mettre l'user www-data dans le groupe glpi :

```bash
useradd -s /bin/false -d /var/www/glpi.mondomain.tld glpi
usermod -aG glpi www-data
find /var/www/glpi.mondomain.tld -type d -exec chmod 2770 {} \;
find /var/www/glpi.mondomain.tld -type f -exec chmod 660 {} \;
chmown -R glpi: /var/www/glpi.mondomain.tld
find /etc/glpi -type d -exec chmod 2770 {} \;
find /etc/glpi -type f -exec chmod 660 {} \;
chown -R glpi: /etc/glpi
find /var/lib/glpi -type d -exec chmod 2770 {} \;
find /var/lib/glpi -type f -exec chmod 660 {} \;
chown -R glpi: /var/lib/glpi
find /var/log/glpi -type d -exec chmod 2770 {} \;
find /var/log/glpi -type f -exec chmod 660 {} \;
chown -R glpi: /var/log/glpi
```

### Préparation de l'installation

- Récupérer l'archive de [GLPI](https://glpi-project.org/fr/telecharger-glpi/) et la décompresser dans le dossier /var/www/glpi.mondomain.tld
- Le chemin doit être /var/www/glpi.mondomain.tld/<Les_fichiers_de_glpi>
- Copier l'ensemble des fichiers de /var/www/glpi.mondomain.tld/files vers /var/lib/glpi
- Créer un fichier local_define.php dans /etc/glpi
- Le remplir de la manière suivante :

```php
<?php
define('GLPI_VAR_DIR','/var/lib/glpi');
define('GLPI_DOC_DIR', GLPI_VAR_DIR);
define('GLPI_CRON_DIR', GLPI_VAR_DIR.'/_cron');
define('GLPI_DUMP_DIR', GLPI_VAR_DIR.'/_dumps');
define('GLPI_GRAPH_DIR', GLPI_VAR_DIR.'/_graphs');
define('GLPI_LOCK_DIR', GLPI_VAR_DIR.'/_lock');
define('GLPI_PICTURE_DIR', GLPI_VAR_DIR.'/_pictures');
define('GLPI_RSS_DIR', GLPI_VAR_DIR.'/_rss');
define('GLPI_PLUGIN_DIR', GLPI_VAR_DIR.'/_plugins');
define('GLPI_SESSION_DIR', GLPI_VAR_DIR.'/_sessions');
define('GLPI_TMP_DIR', GLPI_VAR_DIR.'/_tmp');
define('GLPI_UPLOAD_DIR', GLPI_VAR_DIR.'/_uploads');
define('GLPI_CACHE_DIR', GLPI_VAR_DIR.'/_cache');
define('GLPI_LOG_DIR', '/var/log/glpi');
?>
```

Créer un fichier /var/www/glpi.mondomain.tld/inc/downstream.php :

```php
<?php
define('GLPI_CONFIG_DIR','/etc/glpi/');

if (file_exists(GLPI_CONFIG_DIR.'/local_define.php')){require_once
        GLPI_CONFIG_DIR.'/local_define.php';
}
?>
```

### Publication du site

Si besoin se référer à la procédure apache2.

Configuration du virtualhost :

```bash
<VirtualHost *:80>
        DocumentRoot /var/www/glpi.olympus.gr
        ServerName glpi.olympus.gr

        <Directory /var/www/glpi.olympus.gr>
                Options Multiviews Indexes FollowSymLinks
                AllowOverride none
                Require all granted
        </Directory>

</VirtualHost>
```

Il s'agit ici d'une phase de test. Se référer aux procédures apache2 et openssl pour le certificat et https

Il ne reste plus qu'à publier le site avec :

```bash
a2ensite glpi.mondomain.tld.conf
```

La dernière étape est de rajouter une entrée de type A dans le serveur DNS de mondomain.tld :
```
glpi  A <ip_du_serveur_glpi>
```

### Fin de la configuration

Il est maintenant possible de continuer la configuration de glpi à l'adresse http://glpi.mondomain.tld
Se rendre à l'adresse pour terminer la configuration de glpi.

Si tout a été fait correctement, il suffit de renseigner les informations de la base de données. Il faudra ensuite changer les mots de passes des comptes par défaut (ou les désactiver) :

- glpi / glpi
- tech / tech
- normal / normal
- post-only / postonly
