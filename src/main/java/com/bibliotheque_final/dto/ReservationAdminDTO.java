package com.bibliotheque_final.dto;

import java.time.LocalDate;

public class ReservationAdminDTO {
    private Integer id;
    private String nom;
    private String titre;
    private LocalDate dateReservation;
    private String statut;
    private LocalDate majStatut;

    public ReservationAdminDTO(Integer id, String nom, String titre, LocalDate dateReservation, String statut, LocalDate majStatut) {
        this.id = id;
        this.nom = nom;
        this.titre = titre;
        this.dateReservation = dateReservation;
        this.statut = statut;
        this.majStatut = majStatut;
    }

    // Getters
    public Integer getId() { return id; }
    public String getNom() { return nom; }
    public String getTitre() { return titre; }
    public LocalDate getDateReservation() { return dateReservation; }
    public String getStatut() { return statut; }
    public LocalDate getMajStatut() { return majStatut; }

    // Setters
    public void setId(Integer id) { this.id = id; }
    public void setNom(String nom) { this.nom = nom; }
    public void setTitre(String titre) { this.titre = titre; }
    public void setDateReservation(LocalDate dateReservation) { this.dateReservation = dateReservation; }
    public void setStatut(String statut) { this.statut = statut; }
    public void setMajStatut(LocalDate majStatut) { this.majStatut = majStatut; }
} 