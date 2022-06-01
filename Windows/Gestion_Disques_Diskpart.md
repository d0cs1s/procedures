# Gestion des disques avec diskpart
## Prise d'informations

> La procédure suivante doit être réalisée en mode Administrateur

### Lister les disques

```
DISKPART> LIST DISK
  N° disque  Statut         Taille   Libre    Dyn  GPT
  ---------  -------------  -------  -------  ---  ---
  Disque 0    En ligne         32 G octets      0 octets        *
  Disque 1    En ligne         10 G octets     9 G octets        *
  Disque 2    En ligne         10 G octets     9 G octets        *
  Disque 3    En ligne         10 G octets     9 G octets        *
```

### Lister les partitions

```
DISKPART> SELECT DISK 0

Le disque 0 est maintenant le disque sélectionné.

DISKPART> LIST PARTITION

  N° partition   Type              Taille   Décalage
  -------------  ----------------  -------  --------
  Partition 1    Récupération       499 M   1024 K
  Partition 2    Système             99 M    500 M
  Partition 3    Réservé             16 M    599 M
  Partition 4    Principale          31 G    615 M
```

### Lister les volumes

Le disque 0 est toujours sélectionné :

```
DISKPART> LIST VOLUME

  N° volume   Ltr  Nom          Fs     Type        Taille   Statut     Info
  ----------  ---  -----------  -----  ----------  -------  ---------  --------
  Volume 0     D                       DVD-ROM         0 o  0 média
  Volume 1         Récupératio  NTFS   Partition    499 M   Sain
  Volume 2     C                NTFS   Partition     31 G   Sain       Démarrag
  Volume 3                      FAT32  Partition     99 M   Sain       Système
```

### Convertir les disques en dynamique

Après avoir sélectionné le disque voulu : 

```
DISKPART> CONVERT DYNAMIC
```

## Création des volumes 

### Création d'un volume en mirroir (RAID 1)

```
DISKPART> CREATE VOLUME MIRROR SIZE=4000 DISK=1,3

DiskPart a correctement créé le volume.
DISKPART> FORMAT FS=NTFS LABEL="[NomDuVolume]" QUICK 

  100 pour cent effectués

DiskPart a formaté le volume.
DISKPART> ASSIGN [LETTER=D | MOUNT="C:\chemin"]
```

### Création d'un volume en RAID 5

```
DISKPART> CREATE VOLUME RAID SIZE=3000 DISK=1,2,3

DiskPart a correctement créé le volume.
DISKPART> FORMAT FS=NTFS LABEL="Données" quick 

  100 pour cent effectués

DiskPart a formaté le volume.

DISKPART> ASSIGN LETTER=D
```

### Création d'un volume agrégé par bande (RAID 0)

```
DISKPART> CREATE VOLUME STRIPE SIZE=3000 DISK=1,2,3

DiskPart a correctement créé le volume.

DISKPART> FORMAT FS=NTFS LABEL="Database" QUICK

  100 pour cent effectués

DiskPart a formaté le volume.

DISKPART> ASSIGN LETTER=E

DiskPart a correctement assigné la lettre de lecteur ou le point de montage.
```
