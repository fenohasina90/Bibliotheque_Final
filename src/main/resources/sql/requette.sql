SELECT l.id AS livre_id, l.titre AS titre, a.type AS adherant_type
FROM livre_adherant la
JOIN adherant a ON la.adherant_id = a.id
JOIN livre l ON la.livre_id = l.id
WHERE la.adherant_id <= 1;


SELECT l.id AS livre_id, l.titre AS titre, l.exemplaire AS totalExemplaire, t.emprunt AS emprunte,(l.exemplaire - t.emprunt) disponible
FROM livre l
JOIN historique_livre h ON h.livre_id = l.id
JOIN
     (SELECT
           l.id AS livre_id,
           COUNT(CASE
                      WHEN h.statut_id = 2 AND h.date_debut = '2024-01-01'
                           THEN 1
                END) AS emprunt
      FROM livre l
                LEFT JOIN historique_livre h ON l.id = h.livre_id
      GROUP BY l.id
      ORDER BY l.id) t
ON t.livre_id = l.id
GROUP BY l.id, t.emprunt;


SELECT l.id AS livre_id, l.titre AS titre, l.image AS image,l.exemplaire AS exemplaire, (l.exemplaire - t.emprunt) disponible
FROM livre l
JOIN historique_livre h ON h.livre_id = l.id
JOIN
     (SELECT
           l.id AS livre_id,
           COUNT(CASE
                      WHEN h.statut_id = 2 AND h.date_debut = '2024-01-01'
                           THEN 1
                END) AS emprunt
      FROM livre l
                LEFT JOIN historique_livre h ON l.id = h.livre_id
      GROUP BY l.id
      ORDER BY l.id) t
ON t.livre_id = l.id
JOIN livre_adherant la ON la.livre_id = l.id
WHERE la.adherant_id <= 1
GROUP BY l.id, t.emprunt;

-- livre 3 = 3 emprunte dispo = 4
-- livre 1,2 = 2 emprunte  dispo = 8, 3

SELECT * FROM historique_livre WHERE statut_id = 1;


SELECT
    l.id AS livreId,
    l.titre AS titre,
    l.exemplaire AS totalExemplaires,
    COUNT(CASE WHEN sl.nom = 'Emprunte' THEN hl.id END) AS exemplairesIndisponibles,
    (l.exemplaire - COUNT(CASE WHEN sl.nom = 'Emprunte' THEN hl.id END)) AS exemplairesDisponibles
FROM
    livre l
        LEFT JOIN
    historique_livre hl ON l.id = hl.livre_id
        AND hl.id = (
            SELECT MAX(hl2.id)
            FROM historique_livre hl2
            WHERE hl2.livre_id = hl.livre_id
        )
        LEFT JOIN
    statut_livre sl ON hl.statut_id = sl.id
WHERE
        l.id = 3 AND hl.date_debut = '2024-01-01'
GROUP BY
    l.id, l.titre, l.exemplaire

-- emprunt
SELECT COUNT(ed.id) AS nombre_emprunts
FROM emprunt_detail ed
JOIN emprunt e ON ed.emprunt_id = e.id
WHERE ed.livre_id = 3
AND ed.date_debut = '2024-01-01';



-- 
SELECT t.emprunt disponible
FROM livre l
JOIN historique_livre h ON h.livre_id = l.id
JOIN
     (SELECT
           l.id AS livre_id,
           COUNT(CASE
                      WHEN h.statut_id = 2 AND h.date_debut = '2024-01-01'
                           THEN 1
                END) AS emprunt
      FROM livre l
                LEFT JOIN historique_livre h ON l.id = h.livre_id
      GROUP BY l.id
      ORDER BY l.id) t
ON t.livre_id = l.id
WHERE l.id = 3
GROUP BY l.id, t.emprunt;

SELECT COUNT(*) AS nombre_reservation
FROM reservation 
WHERE livre_id = 1
AND date_debut = '2025-01-01';    


