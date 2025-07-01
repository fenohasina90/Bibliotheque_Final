package com.bibliotheque_final.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "emprunt_detail")
public class EmpruntDetail {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "emprunt_id")
    private Emprunt emprunt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "livre_id")
    private Livre livre;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    @Column(name = "date_retour")
    private LocalDate dateRetour;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "type_emprunt_id")
    private TypeEmprunt typeEmprunt;

}