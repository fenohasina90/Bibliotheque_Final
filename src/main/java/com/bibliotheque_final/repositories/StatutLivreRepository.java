package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.StatutLivre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatutLivreRepository extends JpaRepository<StatutLivre, Integer> {
}