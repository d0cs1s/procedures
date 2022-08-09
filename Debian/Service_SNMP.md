# Service SNMP
## Installation 

```bash
apt install snmp snmpd
```

## Configuration de SNMP

La configuration du service snmp se passe dans ce fichier : /etc/snmp/snmpd.conf

On va relier notre communauté à un niveau de sécurité. Ce niveau de sécurité sera rattaché à un groupe de sécurité.
On finira pas créer les vues et les autorisations d'accès aux vues.

```bash
vim /etc/snmp/snmpd.conf

agentAddress udp:161
# à la place de default on peut mettre directement l'ip du serveur centreon
com2sec masecu  default public

group mongroupsecu v2c masecu

# Ici on configure les vues avec les OID souhaitée
view  mavue included .1.3.6.1.2.1

access mongroupsecu "" any noauth exact mavue none none
```
