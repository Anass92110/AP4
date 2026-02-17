-- =========================================
-- Base de données
-- =========================================
CREATE DATABASE IF NOT EXISTS materiel_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE materiel_db;

-- =========================================
-- Table type_materiel
-- =========================================
CREATE TABLE IF NOT EXISTS type_materiel (
                                             id_type INT NOT NULL,
                                             libelle VARCHAR(50) NOT NULL,
                                             PRIMARY KEY (id_type),
                                             UNIQUE KEY uk_type_libelle (libelle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- Table materiel
-- =========================================
CREATE TABLE IF NOT EXISTS materiel (
                                        id_materiel INT NOT NULL,
                                        nom VARCHAR(100) NOT NULL,
                                        annee YEAR NOT NULL,
                                        details TEXT,
                                        id_type INT NOT NULL,
                                        id_parent INT DEFAULT NULL,
                                        PRIMARY KEY (id_materiel),
                                        CONSTRAINT fk_materiel_type FOREIGN KEY (id_type) REFERENCES type_materiel(id_type),
                                        CONSTRAINT fk_materiel_parent FOREIGN KEY (id_parent) REFERENCES materiel(id_materiel)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================================
-- Insertion des types
-- =========================================
INSERT INTO type_materiel (id_type, libelle) VALUES
                                                 (1, 'PC'),
                                                 (2, 'Écran'),
                                                 (3, 'CPU'),
                                                 (4, 'RAM'),
                                                 (5, 'Disque'),
                                                 (6, 'GPU'),
                                                 (7, 'Carte réseau'),
                                                 (8, 'OS'),
                                                 (9, 'Batterie');

-- =========================================
-- Insertion des matériels racine
-- =========================================
INSERT INTO materiel (id_materiel, nom, annee, details, id_type, id_parent) VALUES
                                                                                (1, 'PC 1 – Unité centrale', 2016, NULL, 1, NULL),
                                                                                (2, 'PC 2 – Unité centrale', 2017, NULL, 1, NULL),
                                                                                (3, 'PC 3 – Portable', 2015, 'Inspiron 15-3558', 1, NULL),
                                                                                (4, 'Écran A', 2012, 'HP LA1951g – 19’’ – 1280×1024 – 60 Hz', 2, NULL),
                                                                                (5, 'Écran B', 2010, 'Dell E178FP – 17’’ – 1280×1024', 2, NULL),
                                                                                (6, 'Écran C', 2009, 'Samsung 933SN – 18.5’’ – 1366×768', 2, NULL);

-- =========================================
-- Composants PC 1
-- =========================================
INSERT INTO materiel (id_materiel, nom, annee, details, id_type, id_parent) VALUES
                                                                                (10, 'CPU PC1', 2016, 'Intel Core i3-6100', 3, 1),
                                                                                (11, 'RAM PC1', 2016, '4 Go DDR4 (1×4 Go)', 4, 1),
                                                                                (12, 'Disque PC1', 2016, 'HDD Seagate 500 Go', 5, 1),
                                                                                (13, 'GPU PC1', 2016, 'Intel HD 530', 6, 1),
                                                                                (14, 'Carte réseau PC1', 2016, '1 Gbps', 7, 1),
                                                                                (15, 'OS PC1', 2016, 'Windows 10 Pro', 8, 1);

-- =========================================
-- Composants PC 2
-- =========================================
INSERT INTO materiel (id_materiel, nom, annee, details, id_type, id_parent) VALUES
                                                                                (20, 'CPU PC2', 2017, 'Intel Core i5-7500', 3, 2),
                                                                                (21, 'RAM PC2', 2017, '8 Go DDR4 (2×4 Go)', 4, 2),
                                                                                (22, 'Disque PC2', 2017, 'SSD A400 240 Go', 5, 2),
                                                                                (23, 'GPU PC2', 2017, 'Intel HD 630', 6, 2),
                                                                                (24, 'Carte réseau PC2', 2017, '1 Gbps', 7, 2),
                                                                                (25, 'OS PC2', 2017, 'Pas d’OS', 8, 2);

-- =========================================
-- Composants PC 3
-- =========================================
INSERT INTO materiel (id_materiel, nom, annee, details, id_type, id_parent) VALUES
                                                                                (30, 'CPU PC3', 2015, 'Intel Core i3-5005U', 3, 3),
                                                                                (31, 'RAM PC3', 2015, '4 Go DDR3L', 4, 3),
                                                                                (32, 'Disque PC3', 2015, 'HDD WD Blue 500 Go', 5, 3),
                                                                                (33, 'Batterie PC3', 2015, 'usée (≈ 40 min)', 9, 3),
                                                                                (34, 'OS PC3', 2015, 'Windows 10 Pro', 8, 3);
