package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Livre;
import com.bibliotheque_final.projection.LivreProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface LivreRepository extends JpaRepository<Livre, Integer> {
    @Query(value = """
        SELECT l.id AS livreId, l.titre AS titre, l.image AS image, l.exemplaire AS exemplaire, 
           (l.exemplaire - t.emprunt) AS disponible
    FROM livre l
    JOIN historique_livre h ON h.livre_id = l.id
    JOIN (
         SELECT l.id AS livre_id,
                COUNT(CASE
                      WHEN h.statut_id = 2 AND h.date_debut = :dateDonne
                           THEN 1
                END) AS emprunt
         FROM livre l
         LEFT JOIN historique_livre h ON l.id = h.livre_id
         GROUP BY l.id
         ORDER BY l.id
    ) t ON t.livre_id = l.id
    JOIN livre_adherant la ON la.livre_id = l.id
    WHERE la.adherant_id <= :idAdherant
    GROUP BY l.id, t.emprunt
    """, nativeQuery = true)
    List<LivreProjection> getLivreHome(@Param("dateDonne")LocalDate dateDonne, @Param("idAdherant") Integer idAdherant);

    @Query(value = """
        SELECT t.emprunt AS emprunte
        FROM livre l
        JOIN historique_livre h ON h.livre_id = l.id
        JOIN
             (SELECT
                   l.id AS livre_id,
                   COUNT(CASE
                                  WHEN h.statut_id = 2 AND h.date_debut = :dateDonne
                                   THEN 1
                        END) AS emprunt
              FROM livre l
                        LEFT JOIN historique_livre h ON l.id = h.livre_id
              GROUP BY l.id
              ORDER BY l.id) t
        ON t.livre_id = l.id
        WHERE l.id = :idLivre
        GROUP BY l.id, t.emprunt
    """, nativeQuery = true)
    Integer getStatusLivreDisponibility(@Param("dateDonne") LocalDate dateDonne, @Param("idLivre") Integer idLivre);

    @Query(value = """
        SELECT COUNT(*) AS nombre_reservation
        FROM reservation
        WHERE livre_id = :idLivre
        AND date_debut = :dateDonne
    """, nativeQuery = true)
    Integer getReservationLivreDisponibility(@Param("dateDonne") LocalDate dateDonne, @Param("idLivre") Integer idLivre);
}