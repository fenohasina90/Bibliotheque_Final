package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.TypeEmprunt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TypeEmpruntRepository extends JpaRepository<TypeEmprunt, Integer> {
}