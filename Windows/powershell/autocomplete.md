# Autocomplétion avec PowerShell
## Préambule

Pour les frustrés de l'autocomplétion powershell, il est possible de retrouver une autocomplétion plus ou moins similaire à celle de bash

## Marche à suivre

Ouvrir le fichier contenant le profil powershell ou en créer un si inexistant.

Ajouter les lignes suivantes au profil : 

```
# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

Ceci utilise le module PSReadLine
