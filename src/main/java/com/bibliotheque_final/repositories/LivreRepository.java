package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Livre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LivreRepository extends JpaRepository<Livre, Integer> {
}