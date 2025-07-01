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
@Table(name = "type_emprunt")
public class TypeEmprunt {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "nom", length = 50)
    private String nom;

}