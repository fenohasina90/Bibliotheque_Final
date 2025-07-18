INSERT INTO adherant (type, nbr_reservation, nbr_livre_pret, nbr_jrs_pret) VALUES
('Etudiant', 3, 2, 5),
('Professeur', 5, 4, 10),
('Professionnel', 10, 7, 14);

INSERT INTO utilisateur (nom, prenom, date_naissance, email, mdp, est_admin) VALUES
('admin', '123', '1988-07-22', 'sadmin@gmail.com', 'securepwd456', TRUE);

INSERT INTO utilisateur (nom, prenom, date_naissance, email, mdp, est_admin, id_adherant) VALUES
('Koto', 'Kely', '1992-05-10', 'koto@email.com', '123', FALSE, 3);
('Dupont', 'Jean', '1995-03-15', 'dupont@gmail.com', '12345678', FALSE, 1),
('Lefevre', 'Paul', '2000-11-30', 'paul.lefevre@email.com', 'paul2023', FALSE, 2),

INSERT INTO livre (titre, auteur, age, exemplaire, image) VALUES
('Le Petit Prince', 'Antoine de Saint-Exupery', 8, 10, 'images/petit_prince.jpg'),
('1984', 'George Orwell', 16, 5, 'images/1984.jpg'),
('L etranger', 'Albert Camus', 14, 7, 'images/etranger.jpg'),
('Harry Potter a l ecole des sorciers', 'J.K. Rowling', 10, 12, 'images/harry_potter.jpg'),
('Les Miserables', 'Victor Hugo', 12, 3, 'images/miserables.jpg');

INSERT INTO genre (nom) VALUES
('Fiction'),
('Science-fiction'),
('Philosophie'),
('Fantasy'),
('Classique');

INSERT INTO genre_livre (livre_id, genre_id) VALUES
(1, 1), -- Le Petit Prince -> Fiction
(1, 4), -- Le Petit Prince -> Fantasy
(2, 2), -- 1984 -> Science-fiction
(3, 3), -- L'Étranger -> Philosophie
(4, 4), -- Harry Potter -> Fantasy
(5, 5); -- Les Misérables -> Classique

INSERT INTO livre_adherant (livre_id, adherant_id) VALUES
(1, 1), -- Le Petit Prince prêté à l'adhérant 1 (Etudiant)
(2, 2), -- 1984 prêté à l'adhérant 2 (Professeur)
(3, 3), -- L'Étranger prêté à l'adhérant 3 (Externe)
(4, 1), -- Harry Potter prêté à l'adhérant 4 (Etudiant)
(5, 3); -- Les Misérables prêté à l'adhérant 5 (Professeur)

INSERT INTO historique_livre (livre_id, statut_id, date_debut) VALUES
(3, 3, '2024-01-01'),
(5, 1, '2024-01-01'),
(2, 2, '2024-01-01'), 
(2, 2, '2024-01-01'), 
(3, 2, '2024-01-01'), 
(3, 2, '2024-01-01'), 
(3, 2, '2024-01-01'),
(4, 1, '2024-03-15'),
(5, 2, '2024-04-10'),
(5, 1, '2024-06-20');

INSERT INTO statut_reservation (nom) VALUES 
('En attente'),
('Refusee'),
('Validee'),
('Annulee'),
('Terminee');

INSERT INTO reservation (utilisateur_id, livre_id, date_debut) VALUES
(1, 1, '2025-08-01'), ---9
(2, 1, '2025-07-11'), --10
(3, 1, '2025-07-09'), --11
(1, 2, '2025-07-14'), --12
(4, 4, '2025-07-15'); --13

INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (9, 1, '2025-07-05');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (9, 3, '2025-07-06');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (9, 5, '2025-08-01');


INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (10, 1, '2025-07-05');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (10, 3, '2025-07-05');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (10, 5, '2025-07-11');


INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (11, 3, '2025-07-05');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (11, 3, '2025-07-05');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (11, 4, '2025-07-07');


INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (12, 1, '2025-07-05');


INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (13, 1, '2025-07-05');
INSERT INTO historique_reservation (reservation_id, statut_id, date_debut) VALUES (13, 2, '2025-07-05');