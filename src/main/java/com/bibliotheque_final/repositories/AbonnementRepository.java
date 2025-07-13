package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Abonnement;
import com.bibliotheque_final.projection.AbonnementProjection;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;


public interface AbonnementRepository extends JpaRepository<Abonnement, Integer> {

    @Query(value = """
        SELECT *
        FROM abonnement
        WHERE utilisateur_id = :idUser AND (date_debut <= :dateDebutPret AND date_fin >= :dateDebutPret) 
        AND (date_debut <= :dateFinPret AND date_fin >= :dateFinPret)
        ORDER BY date_debut DESC
    """, nativeQuery = true)
    List<Abonnement> dernierAbonnementUser(@Param("idUser") Integer idUser,
                                     @Param("dateDebutPret") LocalDate dateDebutPret,
                                     @Param("dateFinPret") LocalDate dateFinPret);

    @Query(value = """
        SELECT *
        FROM abonnement
        WHERE utilisateur_id = :idUser
        ORDER BY id ASC 
    """, nativeQuery = true)
    List<Abonnement> findAllByIdUser(@Param("idUser")Integer idUser);

    @Query(value = """
        SELECT u.nom || ' ' ||u.prenom AS nom, u.email AS email, ab.date_debut AS dateDebut, ab.date_fin AS dateFin
        FROM abonnement ab
        JOIN (SELECT MAX(a.id) id, t.utilisateur_id
        FROM abonnement a
        JOIN (SELECT DISTINCT utilisateur_id FROM abonnement) t ON t.utilisateur_id = a.utilisateur_id
        GROUP BY t.utilisateur_id) tab ON tab.id = ab.id
        FULL OUTER JOIN utilisateur u ON ab.utilisateur_id = u.id
    """, nativeQuery = true)
    List<AbonnementProjection> getlisteAbonnement();

}