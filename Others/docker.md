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
## Supprimer une image, un conteneur, un volume

### Lister et supprimer une image

```bash
docker images -a
docker rmi <image1> <image2> <...>
```

### Supprimer un conteneur

D'abord voir la liste de tous les conteneurs : 
```bash
docker ps -a
```

Ensuite supprimer les conteneurs souhaités par id ou par nom : 
```bash
docker rm <ID_ou_nom>
```

### Supprimer un volume

Lister les volumes non utilisé par des conteneurs : 
```bash
docker volume ls -f dangling=true
```

Pour supprimer les volumes de la liste : 
```bash
docker volume prune
```
