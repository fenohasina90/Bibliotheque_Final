package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.HistoriqueLivre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HistoriqueLivreRepository extends JpaRepository<HistoriqueLivre, Integer> {
}