# Docker
## Récupérer une image docker

```shell
docker pull [nomdelimage]
```

## Lancer docker

```shell
docker run -it [nomdelimage]
```

## Créer de la persistance

### Création d'un volume

```shell
docker volume create [monvolume]
```

Par défaut le volume se trouve à /var/lib/docker/volumes. Il est possible de copier des fichiers dedans.

### Lancer docker avec un volume

```shell
docker run -v [nomduvolume]:[/emplacementdansleconteneur] -it [nomdelimage]
```

### Lancer docker avec une commande

```shell
docker run -v [nomduvolume]:[/emplacementdansleconteneur] -it [nomdelimage] [commande avec options, arguments etc]
```

## Lancer une commande

Pour lancer une commande dans un containeur : 

```bash
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
exemple : 
docker exec -ti mon_containeur sh -c "echo bonjour"
```
