# Gestion des utilisateurs et groupes

## Ajout de groupes

Syntaxe

```
groupadd [options] GROUP
```

## Ajout d'utilisateurs

syntaxe

```
useradd [options] LOGIN
```

Ajouter un utilisateur "etudiant" avec l'UID 1010 dont le groupe principale est "stagiaires"
et le groupe secondaire "rtssr" avec le shell Bash et ne disposant pas d'un répertoire perso

```
useradd -u 1010 -g stagiaires -G rtssr -s /bin/bash -M etudiant
```

pour définir un mot de passe à l'utilisateur (en root)

```
passwd USER
```
