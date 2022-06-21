# Les imprimantes
## Installation

### Plusieurs réglages d'impression

Installer les pilotes

Installer un port. Pour installer un port rapidement et éviter le check de Windows, on peut le faire en PowerShell

```shell
Add-PrinterPort -ComputerName "NomDeLaMachine" -Name "NomDuPort" -PrinterHostAddress "192.168.1.48"
```

Installer une imprimante avec un 1er réglage sur le port créé
Installer une deuxième imprimante avec d'autre réglages sur le même port

### Pool d'impression

Installer le nombre de port voulu en fonction du nombre d'imprimante qui appartiendra au pool

Installer une imprimante qui fera fonction de pool

Dans la configuration de cette imprimante, cocher la case "Pool d'impression" et ajouter tous les ports préalablement crées

## Gestion des permissions

### Création des DL

Tout d'abord il faut créer les DL dans l'AD. 

Ensuite ajouter les DL dans les imprimantes sur le serveur d'impression et publier l'imprimante dans l'annuaire.

Ajouter ensuite les Groupes Généraux aux DL dans l'AD.
