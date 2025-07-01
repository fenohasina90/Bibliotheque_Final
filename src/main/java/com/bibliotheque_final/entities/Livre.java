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
@Table(name = "livre")
public class Livre {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "titre")
    private String titre;

    @Column(name = "auteur")
    private String auteur;

    @Column(name = "age")
    private Integer age;

    @Column(name = "image", length = 50)
    private String image;

    @Column(name = "est_etudiant")
    private Boolean estEtudiant;

    @Column(name = "est_prof")
    private Boolean estProf;

    @Column(name = "est_pro")
    private Boolean estPro;

    @Column(name = "est_anonyme")
    private Boolean estAnonyme;

}