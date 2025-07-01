package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
}