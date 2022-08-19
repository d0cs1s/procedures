# Déployer un système Microsoft avec WDS et MDT
## Installation et utilisation de WDS

WDS pour Windows Deployment Service

### Prérequis

Pour installer le rôle WDS il faudra disposer : 
- d'un service DHCP pour le boot PXE
- d'un service DNS
- Un espace disque dédié au service (pour les images) -> Attention à gérer les permissions NTFS pour le compte de service
- facultatif : un active directory

> La procédure suivante se fera dans un contexte de domaine Active Directory
> > Le scénario sera de type nouvelle installation (bare-metal)

### Configuration du service

- Installer le rôle *Service de déploiement Windows* (ou Windows Deployment Service)
- Installer les services de rôle *serveur de déploiement* et *serveur de transport*

Une fois le rôle installé, lancer la console Service de déploiement Windows : 
- Clic-droit sur le serveur -> Configurer
- Renseigner le domaine
- Le partage des données du service (l'espace disque qu'on a réservé plus tôt)
- Configuration de restriction de réponse du serveur PXE : ici pour tous

Notes à propos du serveur DHCP :
- Si le serveur DHCP est sur une autre machine : il n'y a rien à changer
- Si le serveur DHCP est sur le même serveur, il faudra modifier les propriétés WDS -> Ne pas écouter les ports du DHCP et définir les options 60,66,67 du service DHCP

#### Intégration d'une image de démarrage

- Clic-droit sur le conteneur *image de démarrage* (ou boot images) -> Ajouter une image de démarrage.
- Sélectionner une image fichier boot.wim (par exemple celui d'une iso d'installation windows, dans le dossier boot)

#### Intégration d'une image d'installation

- Créer un groupe d'images
- Sélectionner une image install.wim (par exemple celle d'une iso d'installation windows)

Le déploiement est désormais fonctionnel mais non automatique, il est possible d'automatiser le processus avec un fichier de réponse *unattend.xml*

Ce fichier devra être stocké dans le répertoire WDSClientUnattend du partage WDS. Il est configuré dans l'onglet *Client* du serveur.
Redémarrer les services après application du fichier de réponse unattend.xml

Le fichier de réponse peut aussi être lié à une image d'installation s'il contient des informations pour l'installation :
- Sur l'image d'installation -> Onglet Général -> Cocher *Autoriser l'image à s'installer sans assistance* et indiquer le fichier de réponse.

exemple de configuration UEFI avec un compte de service wds (attention aux partitions) :

```xml
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
	<settings pass="windowsPE">
		<component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<SetupUILanguage>
				<UILanguage>fr-fr</UILanguage>
			</SetupUILanguage>
			<InputLocale>fr-fr</InputLocale>
			<SystemLocale>fr-fr</SystemLocale>
			<UILanguage>fr-fr</UILanguage>
			<UILanguageFallback>fr-fr</UILanguageFallback>
			<UserLocale>fr-fr</UserLocale>
		</component>
		<component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<DiskConfiguration>
                <Disk wcm:action="add">
                    <CreatePartitions>
                        <CreatePartition wcm:action="add">
                            <Order>1</Order>
                            <Size>300</Size>
                            <Type>Primary</Type>
                        </CreatePartition>
                        <CreatePartition wcm:action="add">
                            <Order>2</Order>
                            <Size>100</Size>
                            <Type>EFI</Type>
                        </CreatePartition>
                        <CreatePartition wcm:action="add">
                            <Order>3</Order>
                            <Size>128</Size>
                            <Type>MSR</Type>
                        </CreatePartition>
                        <CreatePartition wcm:action="add">
                            <Order>4</Order>
                            <Type>Primary</Type>
                            <Extend>true</Extend>
                        </CreatePartition>
                    </CreatePartitions>
                    <ModifyPartitions>
                        <ModifyPartition wcm:action="add">
                            <Format>NTFS</Format>
                            <Label>WINRE</Label>
                            <Order>1</Order>
                            <PartitionID>1</PartitionID>
                        </ModifyPartition>
                        <ModifyPartition wcm:action="add">
                            <Format>FAT32</Format>
                            <Label>System</Label>
                            <Order>2</Order>
                            <PartitionID>2</PartitionID>
                        </ModifyPartition>
                        <ModifyPartition wcm:action="add">
                            <PartitionID>3</PartitionID>
                            <Order>3</Order>
                        </ModifyPartition>
                        <ModifyPartition wcm:action="add">
                            <Format>NTFS</Format>
                            <Label>Windows</Label>
                            <Letter>C</Letter>
                            <Order>4</Order>
                            <PartitionID>4</PartitionID>
                        </ModifyPartition>
                    </ModifyPartitions>
                    <DiskID>0</DiskID>
                    <WillWipeDisk>true</WillWipeDisk>
                </Disk>
				<WillShowUI>OnError</WillShowUI>
			</DiskConfiguration>
			<WindowsDeploymentServices>
				<ImageSelection>
					<WillShowUI>OnError</WillShowUI>
					<InstallImage>
						<ImageName>Windows_10_Pro_N</ImageName>
						<ImageGroup>W10</ImageGroup>
					</InstallImage>
					<InstallTo>
						<DiskID>0</DiskID>
						<PartitionID>4</PartitionID>
					</InstallTo>
				</ImageSelection>
				<Login>
					<Credentials>
						<Domain>d0cs1s.tld</Domain>
						<Password>Pa$$w0rd</Password>
						<Username>wds</Username>
					</Credentials>
				</Login>
			</WindowsDeploymentServices>
		</component>
	</settings>
</unattend>
```

Pour des configurations plus fines, on utilisera MDT (Microsoft Deployment Toolkit)

## Installation et configuration de Microsoft Deployment Toolkit (MDT)

### Prérequis 

- Windows ADK
- Windows ADK plugin PE (les deux disponibles [ici](https://docs.microsoft.com/fr-fr/windows-hardware/get-started/adk-install)
- MDT (disponible [ici](https://www.microsoft.com/en-us/download/details.aspx?id=54259)

### Installation

Lors de l'installation de MDT, sélectionner au minimum les fonctionnalités suivantes : 
- Outils de déploiement
- Concepteur de fonctions d'acquisistion d'images et de configurations
- Concepteur de configuration
- Outil de migration utilisateur (USMT)

Il faudra créer dossier pour MDT (qui sera ensuite partagé lors de la configuration) -> Gérer les permissions NTFS pour autoriser l'admin et le compte de service en contrôle total

Note sur le compte de service : Il peut aussi servir à l'intégration au domaine du poste déployé. Attention de le mettre en délégation de contrôle avec les droits d'ajout d'ordinateurs à l'annuaire (plus d'info [ici](https://www.danielengberg.com/domain-join-permissions-delegate-active-directory/)

### Configuration

- Lancer la console (mmc) *Microsoft Deployment Workbench*
- Clic-droit sur Deployment Shares -> New deployment share
- Renseigner le chemin du dossier précédemment créé
- Renseigner le nom et la description du partage

Conteneur *Operating System* :
- Clic-droit -> Import OS
- *Full set of source files* -> Sélectionner une iso d'installation windows

Conteneur *Task Sequence* !
- Clic-droit -> New Task Sequence
- Renseigner un ID et un nom
- Sélectionner *Standard client task sequence*
- Sélectionner le système d'exploitation souhaité pour le déploiement
- Spécifier la clé de licence
- Spécifier le nom du compte adminlocal qui sera créé lors du déploiement ainsi que le nom de l'organisation
- Renseigner un mot de passe pour le compte adminlocal
- Terminer la configuration

Pour automatiser le déploiement, on s'appuye sur deux fichiers de réponse *Bootstrap.ini* et *CustomSettings.ini* accessible via le conteneur *MDT Deployment Share*, dans l'onglet *Rules*.

Bootstrap.ini : Automatise l'image de boot WinPE
CustomSettings.ini : Automatise l'image d'installation

Après modification de ces fichiers :
- Dans MDT : Clic-droit sur MDT Deployment Share -> Update Deployment Share
- Dans WDS : Remplacer l'image de démarrage par celle générée dans le dossier MDT

Exemple de bootstrap.ini : 
```
[Settings]
Priority=Default

[Default]
DeployRoot=\\DEPLOY\DeploymentShare$
UserID=deploy
UserDomain=d0cs1s.tld
UserPassword=Pa$$w0rd

KeyboardLocale=fr-FR
KeyboardLocalePE=040c:0000040c

SkipBDDWelcome=YES
```

Exemple de CustomSettings.ini : 
```
[Settings]
Priority=Default
Properties=MyCustomProperty

[Default]
SkipTaskSequence=YES
TaskSequenceID=9
SkipUserData=YES
SkipApplications=YES
SkipAppsOnUpgrade=YES
SkipAdminPassword=YES
AdminPassword=Pa$$w0rd

SkipComputerName=YES
OSDComputerName=Clin-vx
SkipDomainMembership=YES
JoinDomain=fabien.tssr.eni
MachineObjectOU=OU=ordi,OU=ent_d0cs1s,DC=d0cs1s,DC=tld
DomainAdmin=wds
DomainAdminDomain=d0cs1s.tld
DomainAdminPassword=Pa$$w0rd

SkipLocaleSelection=YES
SkipTimeZone=YES
UserLocale=fr-FR
KeyboardLocale=040C:0000040C
TimeZoneName=Romance Standard Time
SkipCapture=YES
SkipBitlocker=YES
SkipSummary=YES

SkipProductKey=YES
```
