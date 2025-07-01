package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Emprunt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmpruntRepository extends JpaRepository<Emprunt, Integer> {
}