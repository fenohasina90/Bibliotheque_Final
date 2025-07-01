package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Abonnement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AbonnementRepository extends JpaRepository<Abonnement, Integer> {
}