package com.bibliotheque_final.service;

import com.bibliotheque_final.entities.*;
import com.bibliotheque_final.projection.ReservationProjection;
import com.bibliotheque_final.repositories.*;
import com.bibliotheque_final.repositories.StatutReservationRepository;
import com.bibliotheque_final.dto.ReservationAdminDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReservationService {
    private final ReservationRepository reservationRepository;
    private final LivreRepository livreRepository;
    private final UtilisateurRepository utilisateurRepository;
    private final AbonnementRepository abonnementRepository;
    private final StatutReservationRepository statutReservationRepository;
    private final HistoriqueReservationRepository historiqueReservationRepository;
    @Autowired
    public ReservationService(ReservationRepository reservationRepository, LivreRepository livreRepository, UtilisateurRepository utilisateurRepository, AbonnementRepository abonnementRepository, StatutReservationRepository statutReservationRepository, HistoriqueReservationRepository historiqueReservationRepository) {
        this.reservationRepository = reservationRepository;
        this.livreRepository = livreRepository;
        this.utilisateurRepository = utilisateurRepository;
        this.abonnementRepository = abonnementRepository;
        this.statutReservationRepository = statutReservationRepository;
        this.historiqueReservationRepository = historiqueReservationRepository;
    }

    public boolean isDateBetweenInclusiveAlt(LocalDate dateToCheck, LocalDate startDate, LocalDate endDate) {
        if (dateToCheck == null || startDate == null || endDate == null) {
            throw new IllegalArgumentException("Les dates ne peuvent pas être null");
        }
        return !dateToCheck.isBefore(startDate) && !dateToCheck.isAfter(endDate);
    }

    public boolean estAbonne(Integer idUser, LocalDate dateAReserve) {
        return abonnementRepository.dernierAbonnementUser(idUser, dateAReserve, dateAReserve).isEmpty();
    }

    public boolean valideAgeLivre(Integer idUser, Integer idlivre) {
        Utilisateur user = utilisateurRepository.findById(idUser).orElse(null);
        Livre livre = livreRepository.findById(idlivre).orElse(null);
        LocalDate dateNaissance = user.getDateNaissance();

        LocalDate currentDate = LocalDate.now();
        Integer ageUser = Period.between(dateNaissance, currentDate).getYears();
        Integer ageLivre = livre.getAge();

        return ageLivre <= ageUser;

    }

    public boolean estDisponible(Integer idLivre, LocalDate dateAReserve){
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        Integer exemplaire = livre.getExemplaire();

        Integer pret = livreRepository.getStatusLivreDisponibility(dateAReserve, idLivre);
        Integer reserve = livreRepository.getReservationLivreDisponibility(dateAReserve, idLivre);

        return exemplaire - (pret + reserve) > 0;
    }

    public void save (Integer idUser, Integer idLivre, LocalDate dateReservation){
        Utilisateur utilisateur = utilisateurRepository.findById(idUser).orElse(null);
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        Reservation reservation = new Reservation();
        reservation.setUtilisateur(utilisateur);
        reservation.setLivre(livre);
        reservation.setDateDebut(dateReservation);
        reservation = reservationRepository.save(reservation);

        StatutReservation statutReservation = statutReservationRepository.findById(1).orElse(null);

        HistoriqueReservation historiqueReservation = new HistoriqueReservation();
        historiqueReservation.setReservation(reservation);
        historiqueReservation.setStatut(statutReservation);
        historiqueReservation.setDateDebut(LocalDate.now());
        historiqueReservationRepository.save(historiqueReservation);

    }

    /*
    * Valider reservation id statut = 3
    * Refuser reservation id statut = 2
    * Annuler reservation id statut = 4
    * Terminer reservation id statut = 5
    * */
    public void changerStatutReservation(Integer idReservation, Integer idStatut) {
        Reservation reservation = reservationRepository.findById(idReservation).orElse(null);
        StatutReservation statutReservation = statutReservationRepository.findById(idStatut).orElse(null);

        HistoriqueReservation historiqueReservation = new HistoriqueReservation();
        historiqueReservation.setDateDebut(LocalDate.now());
        historiqueReservation.setStatut(statutReservation);
        historiqueReservation.setReservation(reservation);

        historiqueReservationRepository.save(historiqueReservation);
    }

    public List<ReservationProjection> getListeReservationAdmin() {
        return reservationRepository.getlisteReservationAdmin();
    }




}
