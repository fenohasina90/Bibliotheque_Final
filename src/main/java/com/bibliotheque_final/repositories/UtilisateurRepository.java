package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Utilisateur;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UtilisateurRepository extends JpaRepository<Utilisateur, Integer> {
    Optional<Utilisateur> findByEmail(String email);

    @Query(value = """
        SELECT id_adherant FROM utilisateur WHERE id = :id
    """,nativeQuery = true)
    Integer getIdAdherant(@Param("id") Integer id);
}