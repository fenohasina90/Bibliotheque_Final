package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Adherant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdherantRepository extends JpaRepository<Adherant, Integer> {
}