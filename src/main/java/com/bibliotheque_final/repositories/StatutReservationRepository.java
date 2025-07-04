package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.StatutReservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatutReservationRepository extends JpaRepository<StatutReservation, Integer> {
}