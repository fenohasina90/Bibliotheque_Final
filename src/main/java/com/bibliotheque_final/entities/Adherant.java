package com.bibliotheque_final.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "adherant")
public class Adherant {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "type", length = 100)
    private String type;

    @Column(name = "nbr_reservation")
    private Integer nbrReservation;

    @Column(name = "nbr_livre_pret")
    private Integer nbrLivrePret;

    @Column(name = "nbr_jrs_pret")
    private Integer nbrJrsPret;

}