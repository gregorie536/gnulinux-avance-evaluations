-- archivage.sql
-- Script SQL pour archiver les données avant anonymisation
-- 1. Créer la base archive si elle n'existe pas
CREATE DATABASE IF NOT EXISTS entreprise_db_archive;
-- 2. Utiliser la base archive
USE entreprise_db_archive;
-- 3. Créer la table clients si elle n'existe pas
CREATE TABLE IF NOT EXISTS clients (
    id INT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    email VARCHAR(255),
    adresse VARCHAR(255),
    mot_de_passe VARCHAR(255)
);
-- 4. Créer la table factures si elle n'existe pas
CREATE TABLE IF NOT EXISTS factures (
    id INT PRIMARY KEY,
    client_id INT,
    montant_total DECIMAL(10, 2),
    date_facture DATE
);
-- 5. Insérer les données depuis la base de production
INSERT INTO entreprise_db_archive.clients (id, nom, prenom, email, adresse, mot_de_passe)
SELECT id,
    nom,
    prenom,
    email,
    adresse,
    mot_de_passe
FROM entreprise_db.clients;
INSERT INTO entreprise_db_archive.factures (id, client_id, montant_total, date_facture)
SELECT id,
    client_id,
    montant_total,
    date_facture
FROM entreprise_db.factures;