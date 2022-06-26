# Utilisation de Github
## Configuration de Git

### Config username

```bash
git config --global user.name "username"
```

### Config email

```bash
git config --global user.email username@email.com
```

### Stockage du mot de passe

Le mot de passe du compte ne servira pas ici. Pour configurer et stocker l'accès aux dépôts :

- Sur GitHub, se rendre dans les paramètres du compte
- Options pour les développeurs
- Personal access token (PAT)
- Créer un nouveau token avec les droits voulus
- Copier le token obtenu

Configurer le stockage du token : 

```bash
git config --global credential.helper store
```

Cloner un répertoire privé ou push un commit pour se voir demander ses identifiants. Le mot de passe est le token obtenu.
C'est la dernière fois que les identifiants sont demandés.

Le fichier créé pour stocker le PAT se trouve ici : ~/.git-credentials
Il est en lecture/écriture pour l'utilisateur seulement

## Clone d'un répertoire Github

```shell
git clone {urlduRepo}
```

## Procédure de commit

### Tracking des changements

Après la modification d'un fichier local :

```shell
git add {cheminDuFichierLocal}
```

### Commit des changements

```shell
git commit -m "Message du commit"
```

### Push des changements

```shell
git push
```

## Mise à jour du dépot local

> Il faut qu'un dépôt local soit préalablement créé avec git clone


```shell
git fetch
...
git pull
```

