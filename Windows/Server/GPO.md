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

## Configuration

### Proxy

Configuration utilisateur --> Préférences --> Paramètres du Panneau de configuration

Clique droit sur "Paramètres Internet" --> Internet explorer 10 --> Onglet connexion --> Paramètres Réseau

Entrer les informations du proxy.

> Attention : appuyer sur F5 avant de valider la fenêtre
>> Les lignes doivent être vertes

### Fond d'écran

Déposer le fond d'écran prévu dans un partage qui autorise les ordinateurs du domaine en lecture.

Créer une GPO ordinateur --> paramètres windows --> Fichier

Mettre en source l'adresse réseau, et en destination l'adresse locale (l'endroit où doit se mettre le fond d'écran sur les machines clientes.

Dans cette GPO, ajouter une règle Utilisateur --> Modèle d'admin --> Bureau --> Changer le papier peint.


