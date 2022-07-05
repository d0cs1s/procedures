# iptables
## Visualisation des règles définies

Pour visualiser les règles déjà en place :

```bash
iptables -L
```

## Bloquer une IP

```bash
iptables -A INPUT -s <IP> -j DROP
```

## Bloquer une IP sur un port spécifique

```bash
iptables -A INPUT -s <ip> -p tcp --destination-port <port> -j DROP
```

## Débloquer une IP

```bash
iptables -D INPUT -s <ip> -j DROP
```
