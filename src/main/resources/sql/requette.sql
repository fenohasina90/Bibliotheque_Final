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

-- liste reservation cote admin


select u.nom nom, l.titre titre, r.date_debut date_reservation, his.reservation_id reservation, his.date_debut date_mAJ , st.nom statut 
from historique_reservation his
join (select MAX(hr.id) id, t.id id_res from historique_reservation hr 
join (select id from reservation) t on t.id = hr.reservation_id
group by t.id) tab on his.id = tab.id
join reservation r on r.id = his.reservation_id
join utilisateur u on u.id = r.utilisateur_id
join livre l on l.id = r.livre_id
join statut_reservation st on his.statut_id = st.id
order by r.id desc;



-- liste reservation cote client
select u.nom nom, l.titre titre, r.date_debut date_reservation, st.nom statut,
hr.date_debut date_statut 
from reservation r
join historique_reservation hr on hr.reservation_id = r.id
join utilisateur u on u.id = r.utilisateur_id
join livre l on l.id = r.livre_id
join statut_reservation st on hr.statut_id = st.id
where u.id = ?;

(select MAX(hr.id) id, t.id id_res from historique_reservation hr 
join (select id from reservation) t on t.id = hr.reservation_id
group by t.id) tab;

