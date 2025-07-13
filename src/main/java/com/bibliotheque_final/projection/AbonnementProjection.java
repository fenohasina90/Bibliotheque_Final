package com.bibliotheque_final.projection;

import java.time.LocalDate;

public interface AbonnementProjection {
    String getNom();
    String getEmail();
    LocalDate getDateDebut();
    LocalDate getDateFin();
}
