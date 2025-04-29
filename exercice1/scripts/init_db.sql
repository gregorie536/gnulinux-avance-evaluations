-- init_db.sql
-- Script pour créer la base de données, les tables et insérer les données de test
CREATE DATABASE IF NOT EXISTS entreprise_db;
USE entreprise_db;
-- Table clients
CREATE TABLE IF NOT EXISTS clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    email VARCHAR(255),
    adresse VARCHAR(255),
    mot_de_passe VARCHAR(255)
);
-- Table factures
CREATE TABLE IF NOT EXISTS factures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    montant_total DECIMAL(10, 2),
    date_facture DATE,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);
-- Insertion de données de test
INSERT INTO clients (nom, prenom, email, adresse, mot_de_passe)
VALUES (
        'Dupont',
        'Jean',
        'jean.dupont@example.com',
        '123 rue Principale, Paris',
        'motdepasse123'
    ),
    (
        'Durand',
        'Marie',
        'marie.durand@example.com',
        '456 avenue République, Lyon',
        'motdepasse456'
    ),
    (
        'Martin',
        'Paul',
        'paul.martin@example.com',
        '789 boulevard Voltaire, Marseille',
        'motdepasse789'
    );
INSERT INTO factures (client_id, montant_total, date_facture)
VALUES (1, 2500.00, '2025-01-15'),
    (2, 3200.50, '2025-02-20'),
    (3, 4100.75, '2025-12-10');