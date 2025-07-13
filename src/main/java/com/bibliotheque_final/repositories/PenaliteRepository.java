package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Penalite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PenaliteRepository extends JpaRepository<Penalite, Integer> {

    // Verification @ emprunt sy reservation
    @Query( """
        SELECT p FROM Penalite p WHERE p.emprunt.utilisateur.id = :idUser 
        AND (p.dateDebut <= :datePret AND p.dateFin  >= :datePret) 
        OR (p.dateDebut <= :datefin AND p.dateFin  >= :datefin)
    """)
    List<Penalite> findPenaliteUser(@Param("idUser") Integer idUser,
                                    @Param("datePret")LocalDate datePret,
                                    @Param("datefin") LocalDate dateFin);

    // Verification atao rehefa micreer penalite
    @Query("""
        SELECT p FROM Penalite p WHERE p.emprunt.utilisateur.id = :idUser
    """)
    List<Penalite> getListPenliteUser(@Param("idUser") Integer idUser);

    @Query(value = """
        select MAX(p.date_fin) date_fin from penalite p
        join emprunt e on e.id = p.emprunt_id
        join utilisateur u on u.id = e.utilisateur_id
        where u.id = :idUser
    """, nativeQuery = true)
    LocalDate getDateMaxPenalite(@Param("idUser") Integer idUser);

    @Query("""
        SELECT p FROM Penalite p WHERE p.emprunt.id = :idEmprunt
    """)
    Penalite estPenaliser(@Param("idEmprunt") Integer idEmprunt);


}