# Exercice 1 - Mise en conformité RGPD

---

## 1. Identification des données personnelles

Dans le cadre de l'exercice, la base de données MySQL contient les informations suivantes concernant les clients :

- Nom
- Prénom
- Adresse e-mail
- Adresse postale
- Mot de passe

Ainsi que les informations sur les factures :

- Montant total
- Date de la facture

Toutes ces données sont considérées comme **des données personnelles** au sens du RGPD car elles permettent d'identifier directement ou indirectement une personne.

> **Remarque** : Conformément aux recommandations de la CNIL, les données de contact doivent être supprimées ou anonymisées après la fin de la relation commerciale, sauf obligation légale de conservation.

---

## 2. Processus de mise en conformité

Le processus de mise en conformité suit les étapes suivantes :

1. **Archivage** des données personnelles avant anonymisation, afin de conserver l'historique des ventes.
2. **Anonymisation** des données sensibles dans la base de production, de manière irréversible.
3. **Planification automatique** de ces opérations pour garantir leur exécution annuelle.

Voici un schéma simplifié du processus :

```bash
Production (Base MySQL)
      ↓ (Archivage des données dans une base archive)
      ↓ (Anonymisation des données en production)
      ↓ (Génération de rapport CA annuel)
```

> **Remarque** : Le processus d'anonymisation est préférable au simple effacement car il permet de conserver des données statistiques sans risque pour la vie privée.


## 3. Implémentation technique
### 3.1. Base de données de test

Une base de données entreprise_db est créée, contenant deux tables :

- clients
- factures

Un script init_db.sql sera fourni pour créer la base, les tables, et insérer un jeu de données de test.

> **Remarque** : Pour faciliter les tests, les mots de passe sont stockés en clair dans l'exemple mais doivent être hashés en production.

### 3.2. Scripts Shell et SQL

Les scripts suivants sont utilisés :

- `scripts/init_db.sql` : création de la base et insertion des données.

- `scripts/anonymisation.sh` : anonymisation des données dans la base de production.

- `scripts/archivage.sql` : sauvegarde des données originales dans une base archive.

### 3.3. Tâches CRON

Les opérations sont planifiées via des tâches cron exécutées une fois par an 

- Archivage le 22 décembre à 03h55
- Anonymisation le 22 décembre à 04h00
- Génération du rapport annuel le 22 décembre à 04h05

Le fichier crontab ressemblera à ceci :

```bash
55 3 22 12 * bash /chemin/vers/scripts/archivage.sh
00 4 22 12 * bash /chemin/vers/scripts/anonymisation.sh
05 4 22 12 * bash /chemin/vers/scripts/generation_rapport.sh
```

> **Remarque** : L'utilisation de tâches cron garantit que le processus est automatique et régulier sans intervention humaine.

## 4. Génération automatique des rapports
Un script shell generation_rapport.sh génère un rapport du chiffre d'affaires total par mois, à partir des deux bases de données (production et archive).

Le rapport est produit au format texte lisible, par exemple :

```bash
Rapport Annuel 2025

Janvier : 2500 €
Février : 3200 €
...
Décembre : 4100 €
```

> **Remarque** : Le format texte est choisi pour sa simplicité d'archivage et de consultation.

## 5. Instructions d'installation et d'utilisation
Cloner ce dépôt :

```bash
git clone https://github.com/gregorie536/gnulinux-avance-evaluations.git
```

Se placer dans exercice1/scripts.

Exécuter le script d'initialisation de la base de données :

```bash
mysql -u root -p < init_db.sql
```

Ajouter les tâches cron en utilisant crontab -e.

## 6. Conclusion
Le processus mis en place respecte les exigences du RGPD :

- Anonymisation des données personnelles sensibles.
- Archivage sécurisé des données avant traitement.
- Génération de rapports réguliers pour le suivi d'activité.


> **Remarque** : En situation réelle, il serait également nécessaire de protéger les bases par des mécanismes d'accès sécurisé, de chiffrement au repos, et d'auditer régulièrement les procédures.