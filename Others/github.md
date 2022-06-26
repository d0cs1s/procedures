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

