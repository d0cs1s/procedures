# Perte de mot de passe admin
## Procédure 

En cas de perte du mot de passe administrateur et si l'accès physique à la machine est possible :

- Démarrer la machine
- Dans le grub appuyer sur E
- Chercher 'quiet' et le remplacer par init=/bin/bash

Une fois le système booté, il faut monter la racine :

```bash
mount -n -o remount,rw /
```

Il ne reste plus qu'à changer le mot de passe avec la commande passwd
