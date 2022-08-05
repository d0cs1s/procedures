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
mysql -u <user> -p
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

### Ajouter du contenu

//TODO

## La commande SELECT

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

// TODO tri en sortie, limit et offset, compter, alias, max / min / somme / moyenne
