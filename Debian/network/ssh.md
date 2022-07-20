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
ssh-keygen
```

- Touche entrée pour valider l'emplacement par défaut du fichier (/home/profil/.ssh/id_rsa par défaut)
- Entrer un mot de passe (facultatif)

### Copie de la clé publique

Pour initialiser une connexion, le serveur doit disposer de la clé publique de l'utilisateur :

```bash
ssh-copy-id profil@172.30.0.254
```

#### Bonus Windows

```powershell
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh -p <port> {user}@{IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"
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
scp <source> <destination>
```

Exemple de téléchargement d'un fichier :

```bash
scp profil@172.30.0.254:/etc/network/interfaces /home/profil/backup/interfaces
```

Exemple d'upload d'un fichier :

```bash
scp /home/profil/backup/interfaces profil@172.30.0.254:/etc/network/interfaces
```
