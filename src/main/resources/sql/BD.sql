CREATE DATABASE bibliotheque;

\c bibliotheque;

CREATE TABLE livre(
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255),
    auteur VARCHAR(255),
    age INT,
    image VARCHAR(50)
);


CREATE TABLE adherant(
    id SERIAL PRIMARY KEY,
    type VARCHAR(100),
    nbr_reservation INT,
    nbr_livre_pret INT,
    nbr_jrs_pret INT
);

CREATE TABLE genre(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255)
);

CREATE TABLE livre_adherant(
    id SERIAL PRIMARY KEY,
    livre_id INT REFERENCES livre(id),
    adherant_id INT REFERENCES adherant(id)
);  

CREATE TABLE statut_livre(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) -- Disponible, Emprunte
);

CREATE TABLE type_emprunt(
    id INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE utilisateur(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    date_naissance DATE,
    email VARCHAR(255),
    mdp VARCHAR(50),
    est_admin BOOLEAN,
    id_adherant INT REFERENCES adherant(id)
);

CREATE TABLE abonnement(
    id SERIAL PRIMARY KEY,
    utilisateur_id INT REFERENCES utilisateur(id),
    date_debut DATE,
    date_fin DATE
);

CREATE TABLE emprunt(
    id SERIAL PRIMARY KEY,
    utilisateur_id INT REFERENCES utilisateur(id) 
);

CREATE TABLE emprunt_detail(
    id SERIAL PRIMARY KEY,
    emprunt_id INT REFERENCES emprunt(id),
    livre_id INT REFERENCES livre(id),
    date_debut DATE,
    date_fin DATE,
    date_retour DATE,
    type_emprunt_id INT REFERENCES type_emprunt(id)
);

CREATE TABLE penalite(
    id SERIAL PRIMARY KEY,
    emprunt_id INT REFERENCES emprunt(id),
    sanction INT 
);

CREATE TABLE reservation(
    id SERIAL PRIMARY KEY,
    utilisateur_id INT REFERENCES utilisateur(id),
    livre_id INT REFERENCES livre(id),
    date_debut DATE
);

CREATE TABLE statut_reservation(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) -- En attente, Refusee, Validee, Annuler, Terminee
);

CREATE TABLE historique_reservation(
    id SERIAL PRIMARY KEY,
    reservation_id INT REFERENCES reservation(id),
    statut_id INT REFERENCES statut_reservation(id),
    date_debut DATE DEFAULT CURRENT_DATE
);

CREATE TABLE genre_livre(
    livre_id INT REFERENCES livre(id),
    genre_id INT REFERENCES genre(id)
);

CREATE TABLE historique_livre(
    id SERIAL PRIMARY KEY,
    livre_id INT REFERENCES livre(id),
    statut_id INT REFERENCES statut_livre(id),
    date_debut DATE
);
