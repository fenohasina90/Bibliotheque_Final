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


-- penalite
select u.id utilisateur, count(u.id) nombre_penalite from emprunt_detail ed
join emprunt e on e.id = ed.emprunt_id
join utilisateur u on u.id = e.utilisateur_id
where (ed.date_fin < CURRENT_DATE and ed.date_retour is null) or ed.date_retour > ed.date_fin
group by u.id;


select e.id emprunt_nahazona_penalite from emprunt_detail ed
join emprunt e on e.id = ed.emprunt_id
join utilisateur u on u.id = e.utilisateur_id
where ((ed.date_fin < CURRENT_DATE and ed.date_retour is null) or ed.date_retour > ed.date_fin) and u.id = 3
group by e.id;

select MAX(ed.date_fin) debut_de_penalite from emprunt_detail ed
join emprunt e on e.id = ed.emprunt_id
join utilisateur u on u.id = e.utilisateur_id
where u.id = 3;

select ed.date_fin debut_de_penalite from emprunt_detail ed
join emprunt e on e.id = ed.emprunt_id
join utilisateur u on u.id = e.utilisateur_id
where u.id = 3;

-- penalite d un utilisateur
select p.* from penalite p
join emprunt e on e.id = p.emprunt_id
join utilisateur u on u.id = e.utilisateur_id
where u.id = 3;


select MAX(p.date_fin) date_fin from penalite p 
join emprunt e on e.id = p.emprunt_id
join utilisateur u on u.id = e.utilisateur_id
where u.id = 6

select MAX(a.id) id, t.utilisateur_id
from abonnement a
join (select distinct utilisateur_id from abonnement) t on t.utilisateur_id = a.utilisateur_id
group by t.utilisateur_id;

-- liste abonnement cote admin
select u.nom || ' ' ||u.prenom as nom, u.email as email, ab.date_debut as dateDebut, ab.date_fin as dateFin
from abonnement ab
join (select MAX(a.id) id, t.utilisateur_id
from abonnement a
join (select distinct utilisateur_id from abonnement) t on t.utilisateur_id = a.utilisateur_id
group by t.utilisateur_id) tab on tab.id = ab.id
full outer join utilisateur u on ab.utilisateur_id = u.id;


SELECT *
FROM abonnement
WHERE utilisateur_id = 3 AND (date_debut <= '2025-08-15' AND date_fin >= '2025-08-15') 
AND (date_debut <= '2025-08-18' AND date_fin >= '2025-08-18')
ORDER BY date_debut DESC




-- alea

SELECT l.id AS livre_id, l.titre AS titre, l.exemplaire AS totalExemplaire, t.emprunt AS emprunte,(l.exemplaire - t.emprunt) disponible
FROM livre l
JOIN historique_livre h ON h.livre_id = l.id
JOIN
     (SELECT
           l.id AS livre_id,
           COUNT(CASE
                      WHEN h.statut_id = 2 AND h.date_debut = CURRENT_DATE
                           THEN 1
                END) AS emprunt
      FROM livre l
                LEFT JOIN historique_livre h ON l.id = h.livre_id
      GROUP BY l.id
      ORDER BY l.id) t
ON t.livre_id = l.id
WHERE l.id = 3
GROUP BY l.id, t.emprunt;


SELECT l.id AS livre_id, l.titre AS titre, l.auteur AS auteur, l.exemplaire AS totalExemplaire, t.emprunt AS emprunte,(l.exemplaire - t.emprunt) disponible
FROM livre l
JOIN historique_livre h ON h.livre_id = l.id
JOIN
        (SELECT
            l.id AS livre_id,
            COUNT(CASE
                        WHEN h.statut_id = 2 AND h.date_debut = CURRENT_DATE
                            THEN 1
                END) AS emprunt
        FROM livre l
                LEFT JOIN historique_livre h ON l.id = h.livre_id
        GROUP BY l.id
        ORDER BY l.id) t
ON t.livre_id = l.id
WHERE l.id = 3
GROUP BY l.id, t.emprunt


select 
u.nom ||' '|| u.prenom as nom, 
a.type as typeAdherant, a.nbr_livre_pret as quotaPret, 
t.nombre_pret_en_cours as pretCours, 
(a.nbr_livre_pret - t.nombre_pret_en_cours) as restePret,
tab.date_debut as debutAbonnement, tab.date_fin as finAbonnement,
q.date_debut penaliteDebut, q.date_fin penaliteFin
from utilisateur u 
join adherant a on a.id = u.id_adherant
full outer join (select e.utilisateur_id as id, COUNT(*) nombre_pret_en_cours from emprunt e
join emprunt_detail ed on ed.emprunt_id = e.id
where ed.date_retour is null
group by e.utilisateur_id) t on u.id = t.id 
full outer join (select * from abonnement 
where CURRENT_DATE <= date_fin and CURRENT_DATE >= date_debut) tab on tab.utilisateur_id = u.id 
full outer join (select * from penalite p
join emprunt e on e.id = p.emprunt_id) q on q.utilisateur_id = u.id
where u.id = 1;


select * from penalite p
join emprunt e on e.id = p.emprunt_id   
where e.utilisateur_id = 2; 



select * from abonnement where utilisateur_id = 2 and (CURRENT_DATE <= date_fin and CURRENT_DATE >= date_debut);


select e.utilisateur_id as id, COUNT(*) nombre_pret_en_cours, from emprunt e
join emprunt_detail ed on ed.emprunt_id = e.id
where e.utilisateur_id = 3 and ed.date_retour is null;