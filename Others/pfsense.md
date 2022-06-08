# pfsense
## Installation

### Configuration initiale

- RAM : 256 Mo
- Disque dur : 10Go
- Plusieurs cartes réseaux
- iso pfsense

Installer pfsense sur la machine et configurer la langue.

Configurer les Vlans le cas échéant.

Spécifier l'interface WAN et l'interface LAN.

Installer l'interface web

### pfsense en ligne de commande

![Interface pfsense](https://github.com/d0cs1s/procedures/blob/2f2405ccae84f1b299a63fb6de164ee2d4c82272/Others/images/pfsense.png)

L'option 2 permet de configurer les ip de chaque interface réseau


## Configuration

### Table de routage

Pour configurer une route statique :

- Se rendre dans System --> Routing --> Gateway
- Définir sur quelle(s) interface(s) se trouvent des passerelles
- Se rendre ensuite dans l'onglet Static Route pour configurer la route statique

Destination network : le réseau que l'on souhaite joindre
Gateway : la passerelle qui permet d'atteindre ce réseau

### Règles de filtrage

Se rendre dans Firewall --> Rules.

Il est possible de définir des règles de parefeu sur chaque interface (ex : autoriser ICMP)

