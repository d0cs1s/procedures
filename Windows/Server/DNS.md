# Serveur DNS
## Fonctionnement

### Etapes de la résolution de nom

- Lecture du fichier hosts ( system32\drivers\etc\hosts sur Windows | /etc/hosts sur Debian )
- Cache DNS
- Service DNS

> Si l'info est trouvée dans le fichier hosts, la machine n'ira pas interroger le serveur DNS

DNS permet la résolution de noms d'hôtes pleinement qualifiés (ou FQDN Fully Qualified Domain Name)

www.google.fr est un nom de domaine pleinement qualifié

www est la partie hôte
google.fr est le domaine

Serveur résolveur : interroge le serveur hébergeur pour résoudre un nom de domaine. Ne gère pas d'espace de noms
Serveur hébergeur : Fait autorité pour le(s) espace(s) de noms qu'il gère

### Syntaxe du fichier hosts

Adresse IP    Nom
127.0.0.1	  localhost

## Installation Serveur DNS Windows Server

### Mise en place serveur résolveur

Installer un nouveau rôle : Serveur DNS

> Penser à changer la configuration réseau du serveur
>> Serveur DNS préféré : lui-même

Si un serveur DHCP est installé sur le réseau, il faut penser à modifier les options d'étendues pour y mettre la nouvelle adresse DNS.

### Redirection non conditionnelle

Pour résoudre des noms de domaines privés, il faut configurer une redirection non conditionnelle vers le serveur DNS de ce domaine.

Clic droit sur le serveur DNS -> Propriétés -> Onglet redirecteurs

Entrer l'adresse IP du serveur DNS du domaine visé.
