# Prise d'information

## Utilisateur et groupes

```
id
cat /etc/passwd
```

## Services

Pour compter les services systemd en cours de fonctionnement
```
pgrep -c 'd$'
```

Pour connaître les services systemd activés en démarrage automatique :
```
systemctl list-unit-file |grep 'enabled'
```

## Informations configuration réseau

```
hostname
cat /etc/resolv.conf
ip addr
ip route
```

## Informations sur les disques

Info sur les volumes physiques
```
pvs
```

Info sur les groupes de volumes
```
vgs
```

Info sur les volumes logiques
```
lvs
```

Connaître l'espace disque restant
```
df -h
```

## Informations sur les programmes

Savoir où est installé un programme :

```bash
dpkg -L <programmerecherché>
```
