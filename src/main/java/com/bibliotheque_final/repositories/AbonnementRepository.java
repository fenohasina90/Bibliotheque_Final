package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Abonnement;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AbonnementRepository extends JpaRepository<Abonnement, Integer> {

    @Query(value = """
        SELECT *
        FROM abonnement
        WHERE utilisateur_id = :idUser
        ORDER BY date_debut DESC
        LIMIT 1
    """, nativeQuery = true)
    Abonnement dernierAbonnementUser(@Param("idUser") Integer idUser);

    @Query(value = """
        SELECT *
        FROM abonnement
        WHERE utilisateur_id = :idUser
        ORDER BY id ASC 
    """, nativeQuery = true)
    List<Abonnement> findAllByIdUser(@Param("idUser")Integer idUser);
}