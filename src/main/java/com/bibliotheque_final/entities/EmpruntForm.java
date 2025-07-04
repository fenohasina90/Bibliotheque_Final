package com.bibliotheque_final.entities;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class EmpruntForm {
    private Integer utilisateurId;
    private Integer livreId;
    private Integer typeEmpruntId;
    private LocalDate dateDebut;
    private LocalDate dateFin;
}
