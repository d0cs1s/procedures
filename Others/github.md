# Utilisation de Github
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
git fetch origin/main
...
git pull
```

