# 2.1-Estructura-de-dades-N1
## 📄Task description

### Exercici 1 - Òptica
Una òptica, anomenada “Cul d'Ampolla”, vol informatitzar la gestió dels clients/es i vendes d'ulleres.

En primer lloc, l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres. En concret vol saber de cada proveïdor:
El nom
L'adreça (carrer, número, pis, porta, ciutat, codi postal i país)
Telèfon
Fax
NIF.

La política de compres de l'òptica es basa que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber:
La marca.
La graduació de cadascun dels vidres.
El tipus de muntura (flotant, pasta o metàl·lica).
El color de la muntura.
El color de cada vidre.
El preu.

Dels clients/es vol emmagatzemar:
El nom.
L'adreça postal.
El telèfon.
El correu electrònic.
La data de registre.

Quan arriba un/a client/a nou, emmagatzemar el/la client/a que li ha recomanat l'establiment (sempre que algú li hagi recomanat).
El nostre sistema haurà d’indicar qui ha sigut l’empleat/da que ha venut cada ullera.

### Exercici 2 - Pizzeria
T’han contractat per a dissenyar una web que permeti fer comandes de menjar a domicili per Internet.

Tingues en compte les següents indicacions per a modelar com seria la base de dades del projecte:
Per a cada client/a emmagatzemem un identificador únic:
Nom.
Cognoms.
Adreça.
Codi postal.
Localitat.
Província.
Número de telèfon.

Les dades de localitat i província estaran emmagatzemats en taules separades. Sabem que una localitat pertany a una única província, i que una província pot tenir moltes localitats. Per a cada localitat emmagatzemem un identificador únic i un nom. Per a cada província emmagatzemem un identificador únic i un nom.

Una persona pot realitzar moltes comandes, però una única comanda només pot ser realitzat per una única persona. De cada comanda s'emmagatzema un identificador únic:
Data/hora.
Si la comanda és per a repartiment a domicili o per a recollir en botiga.
La quantitat de productes que s'han seleccionat de cada tipus.
El preu total.

Una comanda pot constar d'un o diversos productes.


Els productes poden ser pizzes, hamburgueses i begudes. De cada producte s'emmagatzema un identificador únic:
Nom.
Descripció.
Imatge.
Preu.

En el cas de les pizzes existeixen diverses categories que poden anar canviant de nom al llarg de l'any. Una pizza només pot estar dins d'una categoria, però una categoria pot tenir moltes pizzes.


De cada categoria s'emmagatzema un identificador únic i un nom. Una comanda és gestionada per una única botiga i una botiga pot gestionar moltes comandes. De cada botiga s'emmagatzema un identificador únic:
Adreça.
Codi postal.
Localitat.
Província.


En una botiga poden treballar molts empleats/des i un empleat/da només pot treballar en una botiga. De cada empleat/da, s'emmagatzema un identificador únic:
Nom.
Cognoms.
NIF.
Telèfon.

Si treballa com a cuiner/a o repartidor/a. Per a les comandes de repartiment a domicili interessa guardar qui és el repartidor/a que fa el lliurament de la comanda i la data/hora del moment del lliurament.

### QUERIES

Òptica:


Llista el total de factures d'un client/a en un període determinat.

Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.

Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.


Pizzeria:


Llista quants productes de categoria 'Begudes' s'han venut en una determinada localitat.

Llista quantes comandes ha efectuat un determinat empleat/da.

## 📋Requirements

To get started with this project, you need:

MySQL Server 8.0 or higher

MySQL Workbench 8.0.36 or any compatible version (optional but recommended for easier interaction with the database)

## 🛠️Instalation

Install MySQL Workbench:

Download MySQL Workbench from the official website

## ▶️Execution

Import the Schema: Import the provided SQL file (or run the SQL statements directly) to create the necessary tables and relationships.

Directory "verification_queries" has the SQL files to execute the verifications that asked.
