package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.LivreAdherant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LivreAdherantRepository extends JpaRepository<LivreAdherant, Integer> {
}