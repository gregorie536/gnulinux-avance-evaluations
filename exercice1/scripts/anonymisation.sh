#!/bin/bash
# anonymisation.sh
# Script pour anonymiser les données sensibles dans la base de production

# Variables de connexion
USER="root"
DATABASE="entreprise_db"

# Exécution des requêtes d'anonymisation
mysql -u "$USER" -p "$DATABASE" <<EOF
UPDATE clients
SET 
    nom = CONCAT('Anonyme', id),
    prenom = 'Anonyme',
    email = CONCAT('anonyme', id, '@example.com'),
    adresse = 'Adresse inconnue',
    mot_de_passe = '*****';
EOF
echo "Les données sensibles ont été anonymisées avec succès dans la base de données $DATABASE."
# Vérification de l'anonymisation
mysql -u "$USER" -p "$DATABASE" -e "SELECT * FROM clients WHERE nom LIKE 'Anonyme%';"
echo "Vérification de l'anonymisation effectuée."
# Fin du script
