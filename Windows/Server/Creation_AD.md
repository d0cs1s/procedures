# Active Directory (AD)
## Configuration d'un nouvel AD

### Installation du rôle AD DS

Procéder à la configuration du serveur dns préféré dans la configuration TCP/IP

> Si dans les différentes étapes rien n'est spécifié, cliquer simplement sur "Suivant"

- Dans la fenêtre "Gestionnaire de serveur / Serveur Local" --> Gérer --> Ajouter des rôles et fonctionnalités
- Choisir l'installation basée sur un rôle ou une fonctionnalité
- Sélectionner un serveur du pool de serveur
- Cocher "Services AD DS"
- Confirmer et installer

### Promotion du serveur en contrôleur de domaine

Cliquer sur le drapeau contenant le point d'exclamation : 
- Promouvoir ce serveur en contrôleur de domaine (DC)
- Ajouter une nouvelle forêt
- Choisir un nom de domaine racine (ex: d0cs1s.lcl)
- Ici c'est un nouvel AD --> Laisser le niveau fonctionnel comme il est
- Laisser serveur DNS coché sauf si autre serveur DNS
- Choisir un mot de passe DSRM (Directory Service Recovery Mode)

Les options précédentes sont réalisables avec le script suivant :
```
#
# Script Windows PowerShell pour le déploiement d’AD DS
#

Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "fabien.lcl" `
-DomainNetbiosName "FABIEN" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
```

## Ajouter une machine au domaine

Remplacer le domaine WORKGROUP par votre domaine.

Pour se connecter sur la nouvelle machine, choisir *autre utilisateur* et taper :

login@mon.domaine

Pour voir la liste des machines et utilisateurs de l'AD :
- Outils --> Utilisateurs et ordinateurs de l'active directory
