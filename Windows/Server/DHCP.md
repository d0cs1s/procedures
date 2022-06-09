# DHCP sur Windows Server
## Installation

### Nouveau rôle

Installer le rôle DHCP.

> Le serveur doit forcément être en IP fixe

## Configuration

Dans la console gérant le DHCP :

- Clic droit sur IPv4
- Nouvelle étendue
- Choisir un nom pour la nouvelle étendue
- Entrer la plage d'IP gérée par l'étendue et le masque de sous-réseau
- Ajouter les éventuelles exclusions
- Choisir la durée du bail
- Entrer l'adresse du/des routeurs présents dans l'étendue
- Entrer l'adresse ip du serveur DNS
- Finir en activant l'étendue

> Il est possible de gérer des étendues sur différents réseaux
> > Il faudra mettre en place un DHCP relay sur les réseaux différents de celui du DHCP (ex: avec pfsense)

