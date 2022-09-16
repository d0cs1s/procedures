# MariaDB
## Installation de MariaDB

```bash
apt install mariadb-server
```

## Configuration de mariadb

```bash
mysql_secure_installation

Change the root password? Y # Entrer un nouveau mot de passe
Remove anonymous users? Y
Disallow root login remotely? Y
Remove test database and anccess to it? [Y/n]
Reload privilege tables now? Y
```

## Utilisation de mariadb

### Se connecter à mariadb

```bash
mysql -u <user> -p -h <ip_serveur_distant>
```

### Ajouter un nouvel utilisateur, une bdd et les droits

#### Ajout utilisateur

```mysql
CREATE USER 'user'@'localhost' IDENTIFIED BY 'motdepassecomplexe';
```

#### Création de la base

```mysql
CREATE DATABASE nouvelle_database;
```

#### Ajout des droits au nouvel utilisateur

```mysql
GRANT ALL PRIVILEGES ON nouvelle_database.* TO 'user'@'localhost' IDENTIFIED BY 'motdepassecomplexe';
FLUSH PRIVILEGES;
```

### Lister les bases de données

Permet de lister les bases de données pour lesquelles l'utililsateur courant à les droits :
```mysql
SHOW databases;
```

### Se connecter à une base de données

```mysql
CONNECT <base_de_données>;
```

### Supprimer une base de données

```mysql
DROP database <base_de_données>;
```

### Lister les tables

Une fois connecté à une base de données, pour lister les tables présentes :

```mysql
SHOW tables;
```

### Ajouter/modifier du contenu

//TODO

## La commande SELECT

### Lister les colonnes d'une table

Pour lister les colonnes d'une table afin d'y voir plus clair :

```mysql
SHOW COLUMNS FROM <nom_de_la_table>;
```

### Lister les données d'une table

Pour lister l'ensemble des données d'une table, avec tous les attributs :

```mysql
SELECT * FROM <nom_de_la_table>;
```

Pour lister l'ensemble des données d'une table en sélectionnant des attributs : 

```mysql
SELECT <attribut1>, <attribut2> FROM <table>;
```

Pour ajouter des conditions, on utilise WHERE : 

```mysql
SELECT <attribut1>, <attribut2> FROM <table> WHERE <attributx> = 'quelquechose';
```
On peut utiliser tous les opérateurs de comparaison :
- = : égal
- < <= > >= : inférieur, inférieur ou égal, etc
- <> ou != : différent
- <=> : égal (prend en compte le NULL)

On peut aussi faire des combinaisons de critères :

```mysql
SELECT <attribut1>, <attribut2> FROM <table> WHERE (attributx >= '2' AND attributy = 'quelquechose') OR (attributx >= '2' AND attributy = NULL);
```
- AND : et
- OR : ou
- XOR : ou exclusif (ou mais pas les 2)
- NOT : n'est pas, non, sauf

### Trier les données

Il est possible de trier les données en fonction de la colonne choisie par ordre croissant ( par défaut ) ou décroissant : 

```mysql
SELECT <attribut1>, <attribut2> FROM <table> ORDER BY <attribut1>[, <éventuel_2è_attribut>];
```

### Nombre de lignes à afficher

Restreindre le nombre de ligne à afficher avec LIMIT. Il est possible de commencer à compter à partir d'une certaine ligne avec OFFSET :

```mysql
SELECT <attribut1> FROM <table> ORDER BY <attributx> LIMIT '2' OFFSET '1';
```

### Compter 

Pour compter le nombre de ligne d'un résultat :

```mysql
SELECT COUNT(attribut) FROM <table>;
```

> Donne le nombre de ligne contenant l'attribut sélectionné. Ici le NULL n'est donc pas pris en compte

### Modifier le nom d'un attribut à l'affichage 

Avec la commande AS : 

```mysql
SELECT <attribut1> as <nom_d'affichage_souhaité> FROM <table>;
```

### Traitement (max / min / somme / moyenne)

- MAX : valeur maximum d'une colonne sélectionnée
- MIN : valeur minimum
- SUM : somme des valeurs d'une colonne
- AVG : moyenne d'une colonne

exemple :
```mysql
SELECT AVG(age) FROM clients;
```

// TODO Jointures internes (INNER JOIN)
