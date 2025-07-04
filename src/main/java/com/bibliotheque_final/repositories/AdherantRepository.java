package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Adherant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AdherantRepository extends JpaRepository<Adherant, Integer> {
    @Query("SELECT a.nbrJrsPret FROM Adherant a WHERE a.id = :id")
    Integer getNombreJoursPretById(@Param("id") Integer id);
}