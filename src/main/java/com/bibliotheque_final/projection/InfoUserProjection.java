package com.bibliotheque_final.projection;

import java.time.LocalDate;

public interface InfoUserProjection {
    Integer getId();
    String getNom();
    String getTypeAdherant();
    Integer getQuotaPret();
    Integer getPretCours();
    Integer getRestePret();
    LocalDate getDebutAbonnement();
    LocalDate getFinAbonnement();
    LocalDate getPenaliteDebut();
    LocalDate getPenaliteFin();
}
