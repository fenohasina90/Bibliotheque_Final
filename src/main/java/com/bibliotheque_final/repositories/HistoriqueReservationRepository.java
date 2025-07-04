package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.HistoriqueReservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HistoriqueReservationRepository extends JpaRepository<HistoriqueReservation, Integer> {
}