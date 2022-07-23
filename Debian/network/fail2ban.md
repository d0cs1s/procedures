# Installer et configurer fail2ban
## Installation du paquet

```bash
apt install fail2ban -y
```

## Configuration de fail2ban

S'assurer que le service fail2ban est en démarrage automatique :

```bash
systemctl enable fail2ban
Synchronizing state of fail2ban.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable fail2ban
...
systemctl status fail2ban
● fail2ban.service - Fail2Ban Service
     Loaded: loaded (/lib/systemd/system/fail2ban.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2022-07-23 16:31:00 CEST; 3min 4s ago
```

### Emplacement des fichiers de configurations

/etc/fail2ban/fail2ban.conf : Fichier de configuration général de fail2ban

/etc/fail2ban/jail.conf : Ne pas modifier

/etc/fail2ban/jail.d/*  : Les fichiers à modifier pour configurer les jails, ils surchargent /etc/fail2ban/jail.conf

### Création d'une jail custom

Modifier le fichier /etc/fail2ban/jail.d/defaults-debian.conf pour paramétrer une jail.
Pour l'exemple on configure une jail ssh :

```bash
vim /etc/fail2ban/jail.d/defaults-debian.conf

# Configuration du temps de ban avec incrémentation du temps si une ip a déjà été bannie
# On ignore la boucle local et l'ip locale avec laquelle on se connecte en ssh
[DEFAULT]
ignoreip = 127.0.0.1 <ip_local>
findtime = 15m
bantime = 24h
maxretry = 3
bantime.increment = true
bantime.factor = 1
bantime.formula = ban.Time * (1<<(ban.Count if ban.Count<20 else 20)) * banFactor
destemail = <email de destination si ban> # Pour que cela fonctionne, configurer ssmtp

[sshd]
enabled = true
port = <votre port ssh>
logpath = /var/log/auth.log
maxretry = 3
```

### Dé-ban une ip

Dans le cadre des tests du fonctionnement du service, l'ip de la machine attaquante sera bannie. Pour la dé-bannir manuellement :

```bash
fail2ban-client set sshd unbanip <ip bannie>
```
