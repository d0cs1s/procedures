# Lancer un serveur http rapidement sans config

## Préambule

Python3 intègre un module http.server qui permet de configurer un serveur http facilement.

Cela permet de faire du partage de fichier rapidement en local

## Partage de ficher rapide (LAN)

Pour cela rien de plus simple, une seule commande suffit

```
python3 -m http.server --bind <votreIPlocal> <port>
```

Le serveur se lance dans le répertoire courant. Pensez à cd dans le répertoire souhaité.

exemple de configuration

```
cd /srv
python3 -m http.server --bind 192.168.1.11 9000
```

Lance un serveur http dont la racine se site dans /srv

Il ne reste plus qu'à lancer son navigateur et accéder à http://192.168.1.11:9000
Vous pouvez accéder aux fichiers présent dans ce répertoire et les télécharger simplement.
