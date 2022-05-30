# Gestion des disques avec PowerShell
## Prise d'information

> Cette procédure est à réaliser en mode Administrateur

### Les disques

Pour obtenir la liste des disques sous forme de liste : 
```
PS C:\Users\Administrateur> Get-Disk | Format-List
```

### Les partitions 

Pour la liste des partitions déjà existantes : 

```
PS C:\Users\Administrateur> Get-Partition
```

[Config des partitions](## Gestion des partitions)

### Les volumes

Pour la liste des volumes existants :

```
PS C:\Users\Administrateur> Get-Volume
```

([Config des volumes](https://github.com/d0cs1s/procedures/blob/main/Windows/Gestion_Disques_Powershell.md#gestion-des-volumes))

## Gestion des disques

### Initialisation d'un disque

Après l'ajout d'un nouveau disque dur, il faut l'initialiser : 

```
PS C:\Users\Administrateur> Initialize-Disk -Number [NuméroDuDisque]
```

S'il y a plusieurs disques à initialiser : 

```
PS C:\Users\Administrateur> Get-Disk | Where-Object { $_.OperationalStatus -eq "offline"}  | Initialize-Disk -Passthru
```

> Si un disque MBR est requis : utiliser l'option -PartitionStyle MBR

### Convertion de la table de partition

Si besoin de passer d'une partition MBR à GPT :
```
PS C:\Users\Administrateur> Set-Disk -Number [NuméroDuDisque] -PartitionStyle GPT
```

## Gestion des partitions

> Attention : On parle ici de partitions, non de volumes

### Création d'une partition

```
PS C:\Users\Administrateur> New-Partition -DiskNumber [NuméroDuDisque] -Size [ValeurEnKB/MB/GB/TB]
```

### Redimensionnement d'une partition

//TODO

### Formater une partition

//TODO Format-Volume

### Ajout d'un chemin à une partition

//TODO Add-PartitionAccessPath

### Suppression d'une partition

Pour supprimer une partition : 

```
PS C:\Users\Administrateur> Remove-Partition -DiskNumber [NuméroDuDisque] -PartitionNumber [NuméroDeLaPartition]
```

Confirmer l'action

## Gestion des volumes

> Attention : on parle ici de volumes, non de partitions

Pour la création des différents volumes, il va falloir connaître les différents arguments de l'option -ResiliencySettingName : 
	- Simple (RAID 0 si sur 2 disques : agrégé par bandes)
	- Mirror (RAID 1 avec 2 disques / Similaire à RAID 10 avec 4+ disques)
	- Parity (RAID 5) : 2 disques agrégés par bandes avec 1 disque de parité

### Création d'un volume en miroir (RAID 1)

//TODO : correction de la commande pour sélectionner correctement les disques
```
PS C:\Users\Administrateur> New-Volume -DiskNumber [Disk1, Disk2] -FriendlyName [NomDuVolume] -Size [TailleEnKB/MB/GB/TB] -ResiliencySettingName "Mirror" -FileSystem NTFS -AccessPath "[CheminAccès]"
```


### Création d'un volume avec parité (RAID 5)

//TODO : correction de la commande pour sélectionner correctement les disques
```
PS C:\Users\Administrateur> New-Volume -DiskNumber [Disk1, Disk2, Disk3] -FriendlyName [NomDuVolume] -Size [TailleEnKB/MB/GB/TB] -ResiliencySettingName "Parity" -FileSystem NTFS -AccessPath "[CheminAccès]"
```

### Création d'un volume agrégé par bande (RAID 0)

//TODO : correction de la commande pour sélectionner correctement les disques
```
PS C:\Users\Administrateur> New-Volume -DiskNumber [Disk1, Disk2] -FriendlyName [NomDuVolume] -Size [TailleEnKB/MB/GB/TB] -ResiliencySettingName "Simple" -FileSystem NTFS -AccessPath "[CheminAccès]"
```
