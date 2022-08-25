# Déploiement d'Office365 par GPO

## Mise en place

Créer un partage Office_365 sur le serveur de fichier ou le contrôleur de domaine.

Télécharger officedeploymenttool.exe et l'extraire dans le répertoire partagé.

Il est possible d'utiliser ce [site](https://config.office.com/) pour créer la configuration (fichier .xml) ou d'utiliser les fichiers .xml fournis par le .exe

Sur le site :
- Choisir l'architecture
- Choisir les logiciels à déployer
- Choisir le canal de mise à jour
- Choisir les langues
- Choisir les options d'installation supplémentaire
- Choisir les options de mise à niveau
- Gérer les licences
- Remplir les informations générales
- Exporter la configuration au format xml

## Téléchargement des fichiers d'installation

Ouvrir powershell et télécharger les fichiers d'installation avec Office Deployment Tool

```powershell
PS C:\users\administrator\office_365> .\setup.exe /download \\cd-2k19-fb\office_365\Configuration.xml
```

## Déploiement

Créer une OU pour les machines sur lesquelles déployer Office365

Créer une GPO sur l'OU contenant les machines :

- Editer la GPO
- Ordinateur -> Policies -> Paramètres Windows -> Scripts
- Double-clic sur Startup -> Voir les fichiers
- Créer un fichier .cmd avec le script suivant :

```
\\cd-2k19-fb\Office_365\setup.exe /configure \\cd-2k19-fb\Office_365\Configuration.xml
```

Dans la fenêtre précédente, cliquer sur Ajouter et sélectionner le script créé.

Après mise à jour de la GPO et redémarrage de la machine, le processus *Microsoft Office Click-to-Run* devrait être en exécution pour installer Office
