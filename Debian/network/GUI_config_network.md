# Configuration du réseau sur un client avec GUI
## Configuration via le terminal

Sur un système disposant d'une interface graphique, on n'utilise pas networking.service pour configurer le réseau. On préfèrera utiliser Network Manager.
Pour le faire à partir du terminal on utilisera la commande nmcli

> Il sera bien sûr possible de faire toute la configuration du réseau grâce à la GUI mais ce n'est pas le propos ici

Affichage de la configuration des interfaces :

```bash
nmcli
ens33: connecté to Wired connection 1
  "Intel 82545EM"
...
```

Modification durable et immédiate de l'ip :

```bash
nmcli connection modify Wired\ connection\ 1 ipv4.addresses 192.168.10.1/24 ipv4.method.manual
```

> "Wired\ connection\ 1" s'autocomplète avec tab et se retrouve dans la prise d'info avec la commande nmcli

Configuration de la passerelle par défaut :

```bash
nmcli connection modify Wired\ connection\ 1 ipv4.gateway 192.168.10.254
```

Modification du nom d'hôte :

```bash
nmcli general hostname monhost.domaine.test
```

Configuration du serveur DNS préféré :

```bash
nmcli conncetion modify Wired\ connection\ 1 ipv4.dns 192.168.10.10
```
