# Bind9
## Installation de bind9

```bash
apt install bind9
```

> Note : Les commentaires dans les fichiers de conf de bind9 sont //

## Configuration de bind9

### DNS Résolveur

Le fichier de configuration principal de bind9 se trouve à "/etc/bind/named.conf". Il inclut 3 fichiers différents :
- named.conf.options : configuration des options
- named.conf.local : configuration des zones hébergées localement
- named.conf.default-zone : configuration des zones par défaut

#### ACL dans le fichier named.conf

Il faut définir une acl pour les différents réseaux des postes clients dans le fichier named.conf :

```bash 
// lan_corp = réseaux des postes clients
acl lan_corp { 127.0.0.0/8; 192.168.10.0/24; 172.30.1.0/24; };
```

#### Fichier named.conf.options

Il faudra rajouter l'acl créée dans le fichier named.conf.options :

```bash
allow-query { lan_corp; };
allow-recursion { lan_corp; };
```

> On ne touchera pas au fichier named.conf.default-zones

#### Ajout d'un redirecteur inconditionnel

Dans le fichier named.conf.options modifier la ligne forwarders :

```bash
forwarder {
  10.168.0.3;
};
```

#### Ajout d'un redirecteur conditionnel

Pour ajouter un redirecteur conditionnel, il faut ajouter une zone de type *forward* au fichier /etc/bind/named.conf.local :

```bash
zone lazonedacote.local {
  type forward;
  forward only;
  forwarder { 10.20.0.53; };
};
```

## Configuration service DNS faisant autorité

Un serveur bind9 faisant autorité doit avoir une configuration (/etc/bind/named.conf.local) et des données (/var/cache/bind/db.masuperzone.local)

### Configuration d'un serveur primaire

#### Zone directe 

Dans le fichier /etc/bind/named.conf.local : 

```bash
zone "masuperzone.local" {
  type master;
  file "db.masuperzone.local";
  allow-transfer { ip.du.transfert.zone; };
};
```
Il faut maintenant créer le fichier de données dans /var/cache/bind/db.masuperzone.local :

```bash
; fichier de zone du domaine masuperzone.local
; le point-virgule est un commentaire (ouioui)

$ORIGIN masuperzone.local.
$TTL 86400
@ SOA DEB-S2.masuperzone.local. contact.masuperzone.local. (
20220616 ; serial
86400 ; refresh tous les jours
7200 ; retry toutes les 2 heures
3600000 ; expire
3600 ) ; negative TTL
;
@ NS DEB-S2.masuperzone.local.

DEB-S2  A       192.168.9.12
DEB-S1  A       192.168.9.11
RouTux  A       192.168.9.254
RouTux  A       172.18.9.254
pfSense A       172.30.9.1

dns1    CNAME   DEB-S2.masuperzone.local.
dhcp1   CNAME   DEB-S1.masuperzone.local.

```

Vérifier la configuration avec les commandes : 

```bash
named-checkconf
named-checkzone masuperzone.local /var/cache/bind/db.masuperzone.local
```
> Si la commande *named-checkconf* ne retourne rien, tout semble en ordre
> > La commande *named-checkzone* doit retournner le nom de la zone, son serial et "OK"

Recharger la configuration avec la commande :

```bash
rndc reload
```
> Attention : Si la commande retourne "rndc: connect failed: 127.0.0.1#953: connection refused" --> Il faut autoriser 127.0.0.1/8 dans named.conf (acl)
> > Il est aussi possible de relancer le service mais avec perte des statistiques

#### Zone inverse

La zone inverse de déclare dans le même fichier (named.conf.local) :

```bash
zone "10.168.192.in-addr.arpa" {
  type master;
  file "db.192.168.9.inv";
};
```
> Il faut bien entendu créer le fichier /var/cache/bind/db.192.168.9.inv

Exemple de fichier de zone inverse :

```bash
; zone inverse pour 192.168.9.0/24

$TTL 86400
@ SOA DEB-S2.masuperzone.local. contact.masuperzone.local. (
20220617 ; serial
86400    ; refresh
7200     ; retry 2h
3600000  ; expire
3600     ; negative TTL
)
;

@ NS DEB-S2.fabien-9.eni.
11      PTR     DEB-S1.masuperzone.local.
12      PTR     DEB-S2.masuperzone.local.

```

### Configuration d'un serveur secondaire
//TODO zone de recherche directe et indirectes slave

```bash
zone "9.168.192.in-addr.arpa" {
  type slave;
  masters { ip.du.dns.master; };
  file "db.masuperzone.local";
  # on remet ici l'acl déclarée dans le named.conf
  allow-query { lan_corp; }; 
};
```

## Sécurité

### Configuration DNSSEC

//TODO


### Configuration RNDC

//TODO
