package com.bibliotheque_final.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "livre_adherant")
public class LivreAdherant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "livre_id")
    private Livre livre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "adherant_id")
    private Adherant adherant;

}