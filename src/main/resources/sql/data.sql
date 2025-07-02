INSERT INTO adherant (type, nbr_reservation, nbr_livre_pret, nbr_jrs_pret) VALUES
('Etudiant', 3, 2, 5),
('Professeur', 5, 4, 10),
('Professionnel', 10, 7, 14);

INSERT INTO utilisateur (nom, prenom, date_naissance, email, mdp, est_admin) VALUES
('admin', '123', '1988-07-22', 'sadmin@gmail.com', 'securepwd456', TRUE);

INSERT INTO utilisateur (nom, prenom, date_naissance, email, mdp, est_admin, id_adherant) VALUES
('Dupont', 'Jean', '1995-03-15', 'dupont@gmail.com', '12345678', FALSE, 1),
('Lefevre', 'Paul', '2000-11-30', 'paul.lefevre@email.com', 'paul2023', FALSE, 2),
('Durand', 'Marie', '1992-05-10', 'marie.durand@email.com', 'marie789', FALSE, 3);

