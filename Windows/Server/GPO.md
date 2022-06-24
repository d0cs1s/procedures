# GPO
## Préambule

La stratégie de groupe (GPO) s'applique sur tout le domaine, contrairement à la stratégie locale (LGPO) qui se configure poste par poste.
En cas de conflit la GPO l'emporte sur la LGPO.

La GPO ajoute de la sécurité en entreprise et automatise les actions. Cependant la configuration peut être complexe, les GPO dépendent des versions système.

La GPO se propage toutes les 5 minutes de DC à DC (Domain Controller) et par défaut de 30 à 90 minutes sur les autres machines.

Pour modifier la GPO on passe soit par le registre soit via la console MMC de stratégie de groupe.

> Préférer la console MMC !


## Informations sur l'héritage et la priorité

> Les GPO s'appliquent sur les machines et les utilisateurs
>> Les GPO se placent sur des OU

### Les stratégies par défaut

Default Domain Policy (DDP) : Lié à la racine du domaine. Contient la stratégie de mot de passe.

Default Domain Controller Policy : Liée à l'OU Domain Controller

On crée toutes nos stratégies dans la catégorie "Objets de stratégie de groupe", on les applique ensuite où l'on souhaite (sur un site AD, un domaine, une OU).
Elles s'appliquent ensuite sur les utilisateurs et les ordinateurs liés aux objets de stratégie.

### Priorité et héritage

- Les stratégies sont héritées du parent vers l'enfant.
- Les stratégies héritées sont appliquées avant celles du conteneur courant
- Les stratégies marquées "Appliqué" deviennent prioritaires
- Les stratégies dont le numéro d'ordre est le plus élevé sont d'abord appliquées ( 100 > 50 --> 100 appliqué avant 50 )

### Conflits et paramètres complémentaires

- Un objet peut être soumis à plusieurs stratégies
- Si plusieurs stratégies appliquent des valeurs distinctes d'un même paramètre à un même objet, c'est l'ordre d'application qui compte

### Restriction de liaison

- Le blocage d'héritage : sur un conteneur. Impacte toutes les stratégies héritées
- Le paramètre "Appliqué" : outrepasse l'héritage. Rend la GPO prioritaire
- Les filtres (peu utilisé) : 
	- De sécurité --> Restreint la lecture et l'application de GPO
	- WMI --> Limiter l'application grâce aux requêtes WMI (permet de faire des GPO en fonction des caractéristiques d'une machine : RAM / CPU / Usage / etc)

## Exemples de GPO

Pour trouver des gpo rapidement il existe le site [gpsearch](https://gpsearch.azurewebsites.net/)

### Proxy

Configuration utilisateur --> Préférences --> Paramètres du Panneau de configuration

Clique droit sur "Paramètres Internet" --> Internet explorer 10 --> Onglet connexion --> Paramètres Réseau

Entrer les informations du proxy.

> Attention : appuyer sur F5 avant de valider la fenêtre
>> Les lignes doivent être vertes

### Fond d'écran

Déposer le fond d'écran prévu dans un partage qui autorise les ordinateurs du domaine en lecture. ( Ordinateurs du domaine en ACL sur le partage public )

Créer une GPO ordinateur --> préférences --> paramètres windows --> Fichier

- Mode "créer"
- Mettre en source l'adresse réseau, et en destination l'adresse locale (l'endroit où doit se mettre le fond d'écran sur les machines clientes.
- Décocher archiver.
- Onglet "commun" --> Appliquer une fois et ne pas réappliquer.

Dans cette GPO, ajouter une règle Utilisateur --> Modèle d'admin --> Bureau --> Changer le papier peint.


### Accès Panneau de configuration et outil paramètres

Configuration Utilisateur --> Stratégies --> Modèles d'admin --> Panneau de configuration

Activer la GPO "Interdire l'accès au Panneau de configuration et à l'application Paramètres du PC".

L'appliquer sur les OU concernées.

### Accès Installation de pilotes et MAJ

Par défaut, seuls les membres du groupe Administrateurs sont autorisés à installer de nouveaux pilotes de périphériques sur le système.
Cependant, pour forcer la chose il est possible de désactiver le paramètre suivant :

Configuration ordinateur --> Modèle d'admin --> Système --> Installation de pilotes --> Désactiver "Autoriser les non-admins à installer des pilotes pour ces classes de périphériques

### Empêcher redémarrage automatique

Pour empêcher le redémarrage automatique (Windows Update) alors qu'un utilisateur est connecté : 

Config ordinateur --> Modèles d'admin --> Composants Windows --> Windows Update --> Activer " Pas de redémarrage automatique avec des utilisateurs connectés pour les installations planifiées \[...]"

### Empêcher envoi de télémétrie

Config ordinateur --> Stratégies --> Modèmes admins --> Composants Windows --> Collecte des données --> Désactiver "Autoriser la télémétrie"

Il est aussi possible de bloquer le programme d'amélioration de l'expérience utilisateur Windows (dans paramètres de la communication internet : cf rapport d'erreurs).

### Désactiver Cortana

Config ordinateur --> Stratégies --> Modèmes admins --> Composants Windows --> Rechercher --> Désactiver "Autoriser Cortana"

### Désactiver recherche sur le web

Lors de recherches Windwows, pour ne pas rechercher sur internet :

Config ordinateur --> Stratégies --> Modèmes admins --> Composants Windows --> Rechercher --> Activer "Ne pas autoriser la recherche Web"

### Bloquer MAJ Windows p2p

Pour désactiver l'optimisation de la distribution : 

Config ordinateur --> Stratégies --> Modèles d’administration --> Composants Windows --> Optimisation de la distribution

Modifier le paramètre "Mode de téléchargement : HTTP uniquement"

### Désactiver rapport d'erreurs

Config ordinateur --> Stratégies --> Modèmes admins --> Système --> Gestion de la communication internet --> Paramètres de la communication internet

Désactiver "Rapport d'erreurs Windows"

### Restriction sur média amovibles

Toutes les restrictions d'accès au stockage amovible se trouvent dans les paramètres suivants : 

Config ordinateur --> Stratégies --> Modèmes admins --> Système --> Accès au stockage amovible

Pour désactiver l'ensemble des classes de stockage amovible, activer le paramètre : "Toutes les classes de stockage amovible : refuser tous les accès".

Ce paramètre ayant priorité sur les autres, pour gérer de la lecture seule etc, ne pas utiliser ce paramètre.

### Pousser une imprimante par GPO

Pour pousser une imprimante réseau sur les postes clients :

- Sur le serveur d'impression, répertorier les imprimantes dans l'annuaire
- Après ajout dans l'annuaire, cliquer sur déployer par gpo
