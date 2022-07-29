# SSH
## Configuration initiale

### Installation de openssh-server

Sur les serveurs à joindre en ssh :

```bash
apt install openssh-server
```

### Génération de clés

Côté client il faut générer une clé :

```bash
ssh-keygen -b 8192
```

- Touche entrée pour valider l'emplacement par défaut du fichier (/home/profil/.ssh/id_rsa par défaut)
- Entrer un mot de passe (facultatif mais fortement conseillé)

### Copie de la clé publique

Pour initialiser une connexion, le serveur doit disposer de la clé publique de l'utilisateur :

```bash
ssh-copy-id profil@172.30.0.254
```

#### Bonus Windows

```powershell
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh [-p <port>] {user}@{IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"
```

Il y aura potentiellement une demande de confirmation de connexion.

### Connexion à un serveur

Pour se connecter à un serveur en ssh :

```bash
ssh compte@server
```

### Copie de fichiers

Pour envoyer ou télécharger un fichier depuis/vers un serveur distant :

```bash
scp <source> <destination> [-p port]
```

Exemple de téléchargement d'un fichier :

```bash
scp  [-P port] profil@172.30.0.254:/etc/network/interfaces /home/profil/backup/interfaces
```

Exemple d'upload d'un fichier :

```bash
scp [-P port] /home/profil/backup/interfaces profil@172.30.0.254:/etc/network/interfaces
```

## Sécurité

### Changement du port par défaut

```bash
vim /etc/ssh/sshd_config
```

Décommenter la ligne "#Port 22" et remplacer le port 22 par n'importe quel port compris entre 1024 et 65535

### Changement de l'ip d'écoute

Par défaut, ssh écoute sur 0.0.0.0. Réduire le scope en mettant l'adresse ip avec laquelle on se connecte (ou un range d'adresse).

### Régler l'idle timeout

```
ClientAliveInterval 600
ClientAliveCountMax 0
```

### Autorisation par user ou group

Il est possible de ne laisser la possibilité de connexion qu'à un utilisateur ou un groupe particulier : 

```bash
AllowUsers <user>
ou
AllowGroups <group>
```

### Interdire la connexion en root

```bash
PermitRootLogin No
```

### Interdire la connexion par simple mot de passe

Une fois la clé publique du client sur le serveur. Il peut être bien de désactiver la connexion par mot de passe, pour ne permettre que la connexion par clé privée/publique :

```bash
PasswordAuthentication no
```
