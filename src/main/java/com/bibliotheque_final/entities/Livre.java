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

    @Column(name = "exemplaire")
    private Integer exemplaire;
}