#!/bin/bash
# generation_rapport.sh
# Script pour générer un rapport de chiffre d'affaires par mois

# Variables
USER="root"
DATABASE1="entreprise_db"
DATABASE2="entreprise_db_archive"
ANNEE="2025"
OUTPUT="rapport_annuel_${ANNEE}.txt"

# Demander le mot de passe
echo "Veuillez entrer le mot de passe MySQL :"
read -s PASSWORD

# Supprimer le rapport précédent si il existe
rm -f "$OUTPUT"

# Fonction pour générer le rapport depuis une base
generer_rapport() {
    local DB=$1
    echo "---- Rapport pour la base $DB ----" >> "$OUTPUT"

    mysql -u "$USER" -p"$PASSWORD" "$DB" -N -e "
        SELECT 
            DATE_FORMAT(date_facture, '%M') AS Mois,
            SUM(montant_total) AS Chiffre_Affaires
        FROM factures
        WHERE YEAR(date_facture) = $ANNEE
        GROUP BY Mois
        ORDER BY STR_TO_DATE(Mois, '%M');
    " >> "$OUTPUT"

    echo "" >> "$OUTPUT"
}

# Générer le rapport pour chaque base
generer_rapport "$DATABASE1"
generer_rapport "$DATABASE2"

echo "Le rapport annuel a été généré dans le fichier $OUTPUT."
