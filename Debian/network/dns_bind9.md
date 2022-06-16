# Bind9
## Installation de bind9

```bash
apt install bind9
```

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

#### Configuration DNSSEC

//TODO

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
