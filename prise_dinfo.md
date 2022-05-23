# Prise d'information

## Utilisateur et groupes

```
id
cat /etc/passwd

## Services

Pour compter les services systemd en cours de fonctionnement
```
pgrep -c 'd$'
```

Pour conna�tre les services systemd activ�s en d�marrage automatique :
```
systemctl list-unit-file |grep 'enabled'

## Informations configuration r�seau

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

Conna�tre l'espace disque restant
```
df -h
```
