# Installation d'une PKI racine Microsoft
## Installation du rôle

### Déploiement
Dans le gestionnaire de serveur de l'AD : 

- Gérer -> Ajouter un nouveau rôle
- Ajouter : Service de certificats Active Directory
- Service de rôle : Autorité de certification et Inscription de l'autorité de certification via le web

### Post-Déploiement

- Informations d'identification : compte admin
- Cocher les services précédemment sélectionnés
- Type d'installation : Autorité de certification d'entreprise
- Type d'AC : Autorité de certification racine
- Type de la clé privée : Créer une clé privée
- Chiffrement : RSA 4096 et SHA512
- Valider le nom de l'AC, le suffixe etc.
- Période de validité : 5 ans
- À la fin, confirmer les paramètres souhaités avec le bouton *Configurer*

### Vérification

- Outils -> Autorité de certification (ou certsrv). La PKI doit être visible
- Afficher les propriétés de cette PKI -> Afficher le certificat

Pour info :
- certmgr.msc : Certificats utilisateur
- certlm.msc : Certificats ordinateur

## Modèle de certificat

### Créer un modèle de certificat IIS

- Certsrv : Modèles de certificats -> Gérer
- Dans la liste est présente le modèle *Serveur Web* -> Le dupliquer

Propriétés du nouveau modèle :
```
Onglet Comptabilité :
- Changer les valeurs en fonction de votre infrastructure

Onglet Général :
- Nommer le certificat selon le nom du site (ex: www.d0cs1s.lcl)
- Publier le certificat dans Active Directory

Onglet Sécurité :
- Ajouter le serveur hébergeant IIS
- Autorisation en Lecture / Inscrire
```

Valider et retourner sur l'interface certsrv :
- Modèles de certificats -> Clic-droit -> Nouveau -> Modèle de certificat à délivrer
- Sélectionner le modèle précedemment créé et valider

## Installation du certificat sur le serveur IIS

### Console certlm.msc

- Ouvrir la console certlm.msc
- Sélectionner le dossier *Personnel*
- Clic droit -> Toutes les tâches -> Demander un nouveau certificat
- Si le certificat apparaît non disponible : Attendre ou si possible redémarrer le serveur hébergeant le service web.
- Si des informations supplémentaires complémentaires sont demandées en objet :
  - Nom commun : FQDN du site
- Inscription

### Ajout du certificat au site web

Dans l'interface *Gestionnaire des Services Internet (IIS)* :
- Sur le serveur web -> Clic sur le site web concerné par le certificat
- Liaison -> Ajouter ou modifier la liaison https
- Sélectionner le bon certificat SSL qui doit apparaître dans la liste
