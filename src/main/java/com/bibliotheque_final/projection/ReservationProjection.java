package com.bibliotheque_final.projection;

import java.time.LocalDate;

public interface ReservationProjection {
    Integer getId();
    String getNom();
    String getTitre();
    LocalDate getDateReservation();
    String getStatut();
    LocalDate getMajStatut();
}
