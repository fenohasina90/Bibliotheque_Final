package com.bibliotheque_final.projection;

public interface LivreProjection {
    Integer getLivreId();
    String getTitre();
    String getAuteur();
    String getImage();
    Integer getExemplaire();
    Integer getDisponible();
}
