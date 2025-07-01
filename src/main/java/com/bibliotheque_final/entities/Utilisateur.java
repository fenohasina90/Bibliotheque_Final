package com.bibliotheque_final.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "utilisateur")
public class Utilisateur {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "nom")
    private String nom;

    @Column(name = "prenom")
    private String prenom;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(name = "email")
    private String email;

    @Column(name = "mdp", length = 50)
    private String mdp;

    @Column(name = "est_admin")
    private Boolean estAdmin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherant")
    private Adherant idAdherant;

}