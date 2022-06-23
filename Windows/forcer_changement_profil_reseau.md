# Forcer un changement de profil de parefeu

## Obtenir le profil actuel 

```powershell
PS C:\Users\test> Get-NetConnectionProfile
Name             : Réseau
InterfaceAlias   : Ethernet
InterfaceIndex   : 16
NetworkCategory  : Public
IPv4Connectivity : Internet
IPv6Connectivity : Internet
```

## Changer le profil pour privé 

```powershell
PS C:\Users\test> Set-NetConnectionProfile -Name "Réseau" -NetworkCategory Private
```
