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

## Installation Serveur DNS Resolver Windows Server

### Mise en place serveur résolveur

Installer un nouveau rôle : Serveur DNS

> Penser à changer la configuration réseau du serveur
>> Serveur DNS préféré : lui-même

Si un serveur DHCP est installé sur le réseau, il faut penser à modifier les options d'étendues pour y mettre la nouvelle adresse DNS.

### Redirection non conditionnelle

Pour résoudre des noms de domaines privés, il faut configurer une redirection non conditionnelle vers le serveur DNS de ce domaine.

Clic droit sur le serveur DNS -> Propriétés -> Onglet redirecteurs

Entrer l'adresse IP du serveur DNS du domaine visé.

## Installation Serveur DNS Hébergeur Windows Server

### Mise en place du serveur Hébergeur

On procède de la même manière que pour le DNS Resolveur. C'est la suite qui déterminera le fait que le serveur est hébergeur.

### Création de la zone de recherche directe

- Clic droit sur zone de recherche directe -> Nouvelle zone
- Zone principale
- Donner un nom à la zone (ex : infra.net)
- Valider la création du nouveau fichier de configuration
- Ne pas autoriser les mises à jour dynamiques
- Valider les changements

### Création de la zone de recherche inversée

- Clic droit sur zone de recherche inversée -> Nouvelle zone
- Zone principale
- Zone de recherche inversée IPv4
- entrer l'ID Network
- Ne pas autoriser les mises à jour dynamiques
- Valider les changements

### Création d'un nouvel enregistrement

Pour ajouter un nouvel hôte :

- Clic droit sur la zone de recherche directe créée -> Nouvel hôte
- Entrer le nom d'hôte et l'IP de l'hôte

> Attention : Cocher "Créer un pointeur d'enregistrement PTR associé"
> > Cela permet de créer la recherche inversée associée à cet hôte

Pour ajouter un nouvel alias (si plusieurs services sont hébergés sur la même machine) :

- Clic droit sur la zone de recherche directe créée -> Nouvel Alias
- Donner un nom à l'alias (ex : dns)
- Entrer le FQDN pour l'hôte de destination -> Parcourir -> Choisir l'hôte sur lequel pointe l'alias

## Vérification de la configuration

### Vérifier l'enregistrement du serveur DNS maître

```shell
nslookup -q=soa infra.net
Serveur :   server1.infra.net
Address:  172.23.9.101

infrafb.net
        primary name server = server1
        responsible mail addr = hostmaster
        serial  = 9
        refresh = 900 (15 mins)
        retry   = 600 (10 mins)
        expire  = 86400 (1 day)
        default TTL = 3600 (1 hour)
```

### Vérifier l'ip du(des) serveur(s) faisant autorité pour la zone

```shell
nslookup -q=ns infra.net
Serveur :   server1.infra.net
Address:  172.23.9.101

infrafb.net     nameserver = server1
```

### Vérifier les alias

```shell
nslookup dhcp.infra.net
Serveur :   server1.infra.net
Address:  172.23.9.101

Nom :    server1.infra.net
Address:  172.23.9.101
Aliases:  dhcp.infra.net
```

### Vérifier la recherche inversée

```shell
nslookup 172.23.9.101
Serveur :   server1.infra.net
Address:  172.23.9.101

Nom :    server1.infra.net
Address:  172.23.9.101
```

## Ajouter un redirecteur 

### Redirecteur conditionnel

Pour une requête DNS quand un certain suffixe est présent dans la requête

Pour ajouter un redirecteur conditionnel via l'interface : 

- Clic droit sur redirecteur conditionnel
- Nouveau redirecteur conditionnel
- Ecrire le suffixe dns et l'ip du serveur dns à joindre
- Valider

Sinon en Powershell :

```shell
PS C:\Windows\system32> Add-DnsServerConditionalForwarderZone -Name "infrajb.net" -MasterServers 172.23.15.2 -PassThru

ZoneName                            ZoneType        IsAutoCreated   IsDsIntegrated  IsReverseLookupZone  IsSigned
--------                            --------        -------------   --------------  -------------------  --------
infrajb.net                         Forwarder       False           False           False
```

### Redirecteur (général)

Pour que toutes les requêtes soient envoyées vers un serveur dns en particulier : 

- Clic droit sur le serveur DNS (dans l'interface de config)
- Propriétés
- Onglet Redirecteurs
- Modifier
- Ajouter l'ip du serveur DNS à atteindre

Sinon en Powershell :

```shell
PS C:\Windows\system32> Add-DnsServerForwarder -IPAddress "172.23.16.1"
```

## Enregistrement dynamique

Pour que les clients puissent s'enregistrer dynamiquement :

- Clic-droit sur la zone de recherche directe concernée
- Propriétés
- Dans mise à jour dynamique changer l'option par "Non sécurisé et sécurisé"

Il reste à modifier un réglage dans le DHCP :

- Clic-droit sur l'étendu
- Propriétés onglet DNS
- Toujours mettre à jour dynamiquement les enregistrements DNS

## Tolérance aux pannes

Pour une tolérance au panne et une réplication des données sur le réseau, il faut configurer un transfert de zone.

Sur le serveur maître : 

- Clic-droit sur la zone de recherche directe gérée
- Onglet transfert de zone : autoriser les transferts de zone
- Entrer l'adresse IP du serveur esclave

Sur le serveur esclave :

- Clic droit sur zone de recherche directe : nouvelle zone
- Zone secondaire
- Entrer le nom de la zone
- Entrer l'ip du serveur maître

### Cas d'un serveur secondaire BIND

Dans le cas d'un transfert de zone vers un serveur BIND, il y a quelques manipulations à réaliser : 

Sur Windows :
- Clic-droit sur le serveur DNS --> Propriétés --> Onglet avancé --> Cocher "Activer les zones secondaires BIND"
- Le reste de la procédure est similaire au point précédent (config de la zone de recherche)
- Ne pas oublier d'activer les notifications

Configuration de BIND : 

Pour l'installation se référer à la procédure Debian/network/dns_bind. Quelques changements à apporter :

- Ajouter la ligne "masterfile-format text;" dans le fichier named.conf.options
- Créer les zones dans named.conf.local
- Créer un fichier de db vide pour chaque zone et changer leurs droits : chmod 770 et chown :bind
- Recharger la configuration
