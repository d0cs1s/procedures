# Gestion des utilisateurs et groupes

## Ajout de groupes

Syntaxe

bash```
groupadd [options] GROUP
```

## Ajout d'utilisateurs

syntaxe

bash```
useradd [options] LOGIN
```

Ajouter un utilisateur "etudiant" avec l'UID 1010 dont le groupe principale est "stagiaires"
et le groupe secondaire "rtssr" avec le shell Bash et ne disposant pas d'un r�pertoire perso

bash```
useradd -u 1010 -g stagiaires -G rtssr -s /bin/bash -M etudiant
```

pour d�finir un mot de passe � l'utilisateur (en root)

bash```
passwd USER
```
