# Déployer un système Microsoft avec WDS et MDT
## Installation et utilisation de WDS

WDS pour Windows Deployment Service

### Prérequis

Pour installer le rôle WDS il faudra disposer : 
- d'un service DHCP pour le boot PXE
- d'un service DNS
- Un espace disque dédié au service (pour les images)
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
