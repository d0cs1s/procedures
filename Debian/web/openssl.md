# OpenSSL
## Conseils pour l'organisation des dossiers openssl

Il n'y a rien d'obligatoire à respecter cette façon de faire : 

```bash
tree -d /etc/ssl
|--certs      # Les certificats venant d'autorité de certifications connus
|--certs-auto # Les certificats auto-signés
|--private    # Emplacement des clés privées
|--reqs       # Emplacement des demandes de signatures de certificats
```

## Création d'un certificat autosigné

### Création de la clé

```bash
openssl genrsa -des3 -out /etc/ssl/private/intranet.d0cs1s.lcl.key 4096
```

l'option des3 oblige à l'utilisation d'un mot de passe pour protéger la clé privée. Attention, ce mot de passe (phrase) sera demandé à chaque démarrage du service Apache.
Il sera possible de copier la clé sans mot de passe afin qu'il soit utilisé par apache (cf plus bas).

### Création de la demande de certification

```bash
openssl req -new -key /etc/ssl/private/intranet.d0cs1s.lcl.key -out /etc/ssl/reqs/intranet.d0cs1s.lcl.request.csr
Enter pass phrase for /etc/ssl/private/intranet.d0cs1s.lcl.key:
```

Il faudra entrer le mot de passe de la clé et ensuite répondre au formulaire demandant le pays, la localité etc.

### Obtention du certificat

```bash
openssl x509 -req [-days] -in /etc/ssl/reqs/intranet.d0cs1s.lcl.request.csr -signkey /etc/ssl/private/intranet.d0cs1s.lcl.key -out /etc/ssl/certs-auto/intranet.d0cs1s.lcl.cert
```

x509 : norme spécifiant le format des certificats à clés publiques
days : durée de validité du certificat, la durée par défaut est de 365 jours

### Enlever le mot de passe de la clé privée

Dans le cas d'un certificat pour un site, il peut être intéressant de retirer le mot de passe de la clé.
Ceci afin d'évite qu'Apache (par exemple) nous demande le mot de passe à chaque redémarrage du service (Imaginez avec 500 sites).

```bash
openssl rsa -in /etc/ssl/private/intranet.d0cs1s.lcl.key -out /etc/ssl/private/intranet.d0cs1s.lcl-des3.key
```
On se retrouve avec une 2è clé mais cette fois-ci non protégée par mot de passe.

### Affichage des informations de certificats

Pour afficher toutes les informations : 

```bash
openssl x509 -text -in /etc/ssl/certs-auto/intranet.d0cs1s.lcl.cert
```

Informations sur l'émetteur/récepteur du certificat : 

```bash
openssl x509 -noout -in /etc/ssl/certs-auto/intranet.d0cs1s.lcl.cert -issuer
openssl x509 -noout -in /etc/ssl/certs-auto/intranet.d0cs1s.lcl.cert -subject
```

autres options : 

-dates : pour connaître sa période de validité
-hash : afficher la valeur de hashage
-fingerprint : afficher l'empreinte MD5

## Création d'un certificat par autorité de certification interne (PKI)

## Création d'un certificat Let's Encrypt
