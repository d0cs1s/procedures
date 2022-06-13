# Gestion des disques avec fdisk
## But de la procédure 

- Afficher la table de partition d’un disque 
- Ajouter une nouvelle partition 
- Définition du type de partition 
- Gestion de volumes logiques (LVM) 

## Prérequis 

- Création des volumes physiques (PV)
- Création d’un groupe de volumes (VG)
- Création d’un volume logique (LV)
- Ajouter, agrandir, diminuer une partition LVM
- Gestion du système de fichiers
- Montage du système de fichiers 

## Procédure 

### Afficher la table de partition d’un disque 

 Avec fdisk -l il est possible de voir les informations d’un disque et s’il dispose déjà d’une table de partition 

```shell
root@debian-desktop-fb:~# fdisk -l /dev/sdb 

Disque /dev/sdb : 40 GiB, 42949672960 octets, 83886080 secteurs 
Modèle de disque : VMware Virtual S 
Unités : secteur de 1 × 512 = 512 octets 
Taille de secteur (logique / physique) : 512 octets / 512 octets 
taille d'E/S (minimale / optimale) : 512 octets / 512 octets 
```

 Dans l’exemple ci dessus, il n’y a pas de table de partition, il va donc falloir en créer. 

### Ajouter une nouvelle partition 

 ```shell
root@debian-desktop-fb:~# fdisk /dev/sdb 

Bienvenue dans fdisk (util-linux 2.36.1). 
Les modifications resteront en mémoire jusqu'à écriture. 
Soyez prudent avant d'utiliser la commande d'écriture. 
Le périphérique ne contient pas de table de partitions reconnue. 
Création d'une nouvelle étiquette pour disque de type DOS avec identifiant de disque 0x60a33f6b. 

Commande (m pour l'aide) : 
```
 
Avec fdisk sans option et le chemin du disque, il est possible de réaliser de nombreuses opérations sur les disques. Taper m pour afficher l’aide. 

Pour créer une nouvelle partition, il faut taper n. 
Choisir en suite l’option partition primaire avec p. Laisser ensuite les options par défaut pour le numéro de partition et le premier secteur (en appuyant simplement sur entrée) 
 
Le dernier secteur quant à lui est important. Par défaut il prendra la totalité de l’espace. C’est à cette étape que vous pouvez choisir la taille de la partition. 

### Définition du type de partition 

Pour définir un type de partition, il faut taper « t » pour lancer la fonction. Taper ensuite sur L pour voir les différents types de partitions possibles, ou directement le code hexa si vous le connaissez. 
Il faut écrire les changements sur le disque pour terminer. Avec l’option « w ». 

### Gestion de volumes logiques (LVM) 

#### Prérequis 

Pour créer un nouveau volume logique, il faut que le disque à utiliser soit défini comme « Linux LVM » : option 8E. 

### Création des volumes physiques (PV) 

 
Pour créer un volume physique (un peu comme un disque dynamique sur Windows), il faut utiliser la commande suivante :  

```shell
Pvcreate NomDuVolumePhysique 
```

Si vous souhaitez ajouter le nouveau volume, dans un groupe déjà existant. Préférer la commande vgextend (cf. Ajouter, agrandir, diminuer une partition LVM) 

### Création d’un groupe de volumes (VG) 

//TODO 

### Création d’un volume logique (LV) 

 S’il y a de l’espace disponible dans le VG, il est possible de créer un nouveau volume logique. Avec la commande :  

```shell
root@debian-desktop-fb:~# lvcreate -n var -L 20G debian-desktop-vg  
Logical volume "var" created. 
```  

> Ou l’option « n » donne le nom, l’option -L pour la taille et le VG en dernier argument. 

### Ajouter, agrandir, diminuer une partition LVM 

#### Ajouter un volume physique à un VG 

Pour ajouter un volume physique à un groupe de volume, il faut connaître le nom de son groupe de volumes (VG). Il est possible de l’obtenir avec la commande : 

```shell
vgs 
``` 

Il faut ensuite taper la commande suivante : 

```shell
vgextend VG PV1 PV2 PV3 
```
 
Voici un exemple concret :  

```shell
root@debian-desktop-fb:~# vgextend debian-desktop-vg /dev/sdb1 
Physical volume "/dev/sdb1" successfully created. 
Volume group "debian-desktop-vg" successfully extended 
```
 
#### Agrandir une partition LVM 

Il faut bien sûr avoir de l’espace disponible dans le VG. 

```shell
root@debian-desktop-fb:~# lvextend -L +14.8G /dev/debian-desktop-vg/home  
Rounding size to boundary between physical extents: 14,80 GiB. 
Size of logical volume debian-desktop-vg/home changed from 20,00 GiB (5120 extents) to 34,80 GiB (8909 extents). 
Logical volume debian-desktop-vg/home successfully resized. 
```

Le système de fichier ne prend pas en compte les changements automatiquement, il faut forcer un redimensionnement de l’espace avec : 

```shell
root@debian-desktop-fb:~# resize2fs -fp /dev/debian-desktop-vg/home  
resize2fs 1.46.2 (28-Feb-2021) 
Filesystem at /dev/debian-desktop-vg/home is mounted on /home; on-line resizing required 
old_desc_blocks = 2, new_desc_blocks = 5 
The filesystem on /dev/debian-desktop-vg/home is now 9122816 (4k) blocks long. 
```

#### Diminuer une partition LVM 

//TODO

### Gestions du système de fichiers 

 ```shell
root@debian-desktop-fb:~# lsblk -f 
NAME                            FSTYPE      FSVER            LABEL                 UUID                                   FSAVAIL FSUSE% MOUNTPOINT 

sda                                                                                                                                       

└─sda1                          LVM2_member LVM2 001                               w13rZm-02Gv-AE1z-IpJJ-0nhT-mVOp-ZU2XU7                 

  ├─debian--desktop--vg-SWAP    swap        1                                      51476770-7e4b-4fff-ac44-9d1ed9699fbc                  [SWAP] 

  ├─debian--desktop--vg-root    ext4        1.0                                    a7794478-8235-4e58-82cd-a212011b3cdf     12,8G    25% / 

  ├─debian--desktop--vg-windows vfat        FAT32                                  7327-5ED8                                 4,6G     0% /windows 

  └─debian--desktop--vg-home    ext4        1.0                                    d1fdca90-044c-45f3-83d7-90d5b73d4f34     32,4G     1% /home 

sdb                                                                                                                                       

└─sdb1                          LVM2_member LVM2 001                               Mtimah-vxA4-lv70-52Av-W1Ul-5zpn-fja9I6                 

  ├─debian--desktop--vg-home    ext4        1.0                                    d1fdca90-044c-45f3-83d7-90d5b73d4f34     32,4G     1% /home 

  └─debian--desktop--vg-var                                                                                                               

sr0                             iso9660     Joliet Extension Debian 11.1.0 amd64 n 2021-10-09-10-10-23-00
```

Avec l’option « -f », on peut voir sous forme d’arborescence la liste des périphériques et les informations sur leurs systèmes de fichiers. 

Pour formater un volume en ext4 avec un label personnalisé : 

```shell
root@debian-desktop-fb:~# mkfs.ext4 -L VAR /dev/debian-desktop-vg/var  
mke2fs 1.46.2 (28-Feb-2021) 
Creating filesystem with 5242880 4k blocks and 1310720 inodes 
Filesystem UUID: ce1f7ec4-bd39-464a-838a-57ebf0a0719b 
Superblock backups stored on blocks: 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 4096000 
Allocating group tables: done                             
Writing inode tables: done                             
Creating journal (32768 blocks): done 
Writing superblocks and filesystem accounting information: done    
```

### Montage du système de fichiers 

```shell
root@debian-desktop-fb:~# mount /dev/debian-desktop-vg/var /mnt/var 
```
