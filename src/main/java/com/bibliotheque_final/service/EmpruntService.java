package com.bibliotheque_final.service;

import com.bibliotheque_final.entities.*;
import com.bibliotheque_final.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class EmpruntService {
    private final EmpruntRepository empruntRepository;
    private final PenaliteRepository penaliteRepository;
    private final EmpruntDetailRepository empruntDetailRepository;
    private final UtilisateurRepository utilisateurRepository;
    private final LivreRepository livreRepository;
    private final AbonnementRepository abonnementRepository;
    private final AdherantRepository adherantRepository;
    private final TypeEmpruntRepository typeEmpruntRepository;
    private final HistoriqueLivreRepository historiqueLivreRepository;
    private final StatutLivreRepository statutLivreRepository;
    private final ReservationService reservationService;
    @Autowired
    public EmpruntService(EmpruntRepository empruntRepository, PenaliteRepository penaliteRepository, EmpruntDetailRepository empruntDetailRepository, UtilisateurRepository utilisateurRepository, LivreRepository livreRepository, AbonnementRepository abonnementRepository, AdherantRepository adherantRepository, TypeEmpruntRepository typeEmpruntRepository, HistoriqueLivreRepository historiqueLivreRepository, StatutLivreRepository statutLivreRepository, ReservationService reservationService) {
        this.empruntRepository = empruntRepository;
        this.penaliteRepository = penaliteRepository;
        this.empruntDetailRepository = empruntDetailRepository;
        this.utilisateurRepository = utilisateurRepository;
        this.livreRepository = livreRepository;
        this.abonnementRepository = abonnementRepository;
        this.adherantRepository = adherantRepository;
        this.typeEmpruntRepository = typeEmpruntRepository;
        this.historiqueLivreRepository = historiqueLivreRepository;
        this.statutLivreRepository = statutLivreRepository;
        this.reservationService = reservationService;
    }

    public boolean estAbonne(Integer idUser, LocalDate dateDebut, LocalDate dateFin) {
        return abonnementRepository.dernierAbonnementUser(idUser, dateDebut, dateFin).isEmpty();
    }

    public boolean estDisponible(Integer idLivre, LocalDate dateDebut, LocalDate dateFin) {
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        if (livre == null) return false;

        // Vérifier les emprunts existants pour cette période
        List<EmpruntDetail> emprunts = empruntDetailRepository.findByLivreIdAndDateRange(idLivre, dateDebut, dateFin);

        // Vérifier les réservations pour cette période
        Integer reservations = livreRepository.getReservationLivreDisponibility(dateDebut, idLivre);

        return livre.getExemplaire() > (emprunts.size() + reservations);
    }

    public boolean verifierQuota(Integer idUser) {
        Utilisateur utilisateur = utilisateurRepository.findById(idUser).orElse(null);
        if (utilisateur == null || utilisateur.getIdAdherant() == null) return false;

        Adherant adherant = adherantRepository.findById(utilisateur.getIdAdherant().getId()).orElse(null);
        if (adherant == null) return false;

        // Compter les emprunts en cours de l'utilisateur
        long nbEmpruntsEnCours = empruntDetailRepository.countByUtilisateurIdAndDateFinAfter(idUser, LocalDate.now());

        return nbEmpruntsEnCours < adherant.getNbrLivrePret();
    }

    public boolean verifierDureeEmprunt(Integer idUser, LocalDate dateDebut, LocalDate dateFin) {
        // 1. Validation des dates
        if (dateFin.isBefore(dateDebut)) {
            throw new IllegalArgumentException("Date de fin antérieure à la date de début");
        }

        // 2. Calcul simple avec toEpochDay()
        long joursPret = dateFin.toEpochDay() - dateDebut.toEpochDay();

        // 3. Récupération du quota
        Adherant adherant = utilisateurRepository.findById(idUser)
                .orElseThrow().getIdAdherant();

        // 4. Vérification
        if (joursPret > adherant.getNbrJrsPret()) {
            throw new RuntimeException(String.format(
                    "Durée de %d jours dépasse le quota de %d jours",
                    joursPret, adherant.getNbrJrsPret()));
        }

        return true;
    }

    public boolean verifierPenalite(Integer idUser, LocalDate datePret, LocalDate dateFin) {
        List<Penalite> penalites = penaliteRepository.findPenaliteUser(idUser, datePret, dateFin);

        return penalites.isEmpty();
    }

    public List<TypeEmprunt> getAllType(){
        return typeEmpruntRepository.findAll();
    }

    public EmpruntDetail creerEmprunt(Integer idUser, Integer idLivre, LocalDate dateDebut, LocalDate dateFin, Integer typeEmpruntId) {

        // Si emprunt sur place, date fin = date début
        if (typeEmpruntId == 1) { // ID 1 = Sur place
            dateFin = dateDebut;
        }

        // Vérification que la date de fin est après la date de début (sauf pour sur place)
        if (typeEmpruntId != 1 && dateFin.isBefore(dateDebut)) {
            throw new RuntimeException("La date de fin doit être après la date de début");
        }

        if (!reservationService.valideAgeLivre(idUser, idLivre)){
            throw new RuntimeException("Ce livre n est pas destine pour l age de l'utilisateur");
        }

        if (estAbonne(idUser, dateDebut, dateFin)) {
            throw new RuntimeException("L'utilisateur n'est pas abonné");
        }

        if (!estDisponible(idLivre, dateDebut, dateFin)) {
            throw new RuntimeException("Le livre n'est pas disponible dans cette période");
        }

        if (!verifierQuota(idUser)) {
            throw new RuntimeException("Quota maximum de livres empruntés atteint");
        }

        if (!verifierPenalite(idUser, dateDebut, dateFin)) {
            throw new RuntimeException("L'utilisateur a des pénalités en cours");
        }

        // 5. Vérification de la durée de prêt (nouvelle vérification)
        verifierDureeEmprunt(idUser, dateDebut, dateFin);

        // Création de l'emprunt
        Utilisateur utilisateur = utilisateurRepository.findById(idUser).orElse(null);
        Livre livre = livreRepository.findById(idLivre).orElse(null);
        TypeEmprunt typeEmprunt = typeEmpruntRepository.findById(typeEmpruntId).orElse(null);

        Emprunt emprunt = new Emprunt();
        emprunt.setUtilisateur(utilisateur);
        emprunt = empruntRepository.save(emprunt);

        EmpruntDetail empruntDetail = new EmpruntDetail();
        empruntDetail.setEmprunt(emprunt);
        empruntDetail.setLivre(livre);
        empruntDetail.setDateDebut(dateDebut);
        empruntDetail.setDateFin(dateFin);
        empruntDetail.setTypeEmprunt(typeEmprunt);
        empruntDetail = empruntDetailRepository.save(empruntDetail);

        // Mettre à jour l'historique du livre
        StatutLivre statutEmprunte = statutLivreRepository.findById(2).orElse(null); // ID 2 = Emprunté
        HistoriqueLivre historique = new HistoriqueLivre();
        historique.setLivre(livre);
        historique.setStatut(statutEmprunte);
        historique.setDateDebut(dateDebut);
        historiqueLivreRepository.save(historique);

        return empruntDetail;
    }

    public EmpruntDetail prolongerLivre(Integer idEmprunt, LocalDate dateFin, Integer typeEmpruntId){
        Utilisateur utilisateur = empruntRepository.getUtilisateurEmprunt(idEmprunt);
        Integer idUser = utilisateur.getId();
        EmpruntDetail empruntDetail = empruntDetailRepository.getEmpruntDetail(idEmprunt);

        Integer idLivre = empruntDetail.getLivre().getId();
        Livre livre = livreRepository.findById(idLivre).orElse(null);

        TypeEmprunt typeEmprunt = typeEmpruntRepository.findById(typeEmpruntId).orElse(null);

        LocalDate dateDebutProlongement = empruntDetail.getDateFin();

        if (typeEmpruntId == 1) { // ID 1 = Sur place
            dateFin = dateDebutProlongement;
        }

        // Vérification que la date de fin est après la date de début (sauf pour sur place)
        if (typeEmpruntId != 1 && dateFin.isBefore(dateDebutProlongement)) {
            throw new RuntimeException("La date de fin doit être après la date de début");
        }

        if (!reservationService.valideAgeLivre(idUser, idLivre)){
            throw new RuntimeException("Ce livre n est pas destine pour l age de l'utilisateur");
        }

        if (estAbonne(idUser, dateDebutProlongement, dateFin)) {
            throw new RuntimeException("L'utilisateur n'est pas abonné");
        }

        if (!estDisponible(idLivre, dateDebutProlongement, dateFin)) {
            throw new RuntimeException("Le livre n'est pas disponible pour cette période");
        }

        if (!verifierQuota(idUser)) {
            throw new RuntimeException("Quota maximum de livres empruntés atteint");
        }

        if (!verifierPenalite(idUser, dateDebutProlongement, dateFin)) {
            throw new RuntimeException("L'utilisateur a des pénalités en cours");
        }

        verifierDureeEmprunt(idUser, dateDebutProlongement, dateFin);

        Emprunt emprunt = new Emprunt();
        emprunt.setUtilisateur(utilisateur);
        emprunt = empruntRepository.save(emprunt);

        EmpruntDetail empruntDetailInsert = new EmpruntDetail();
        empruntDetailInsert.setEmprunt(emprunt);
        empruntDetailInsert.setLivre(livre);
        empruntDetailInsert.setDateDebut(dateDebutProlongement);
        empruntDetailInsert.setDateFin(dateFin);
        empruntDetailInsert.setTypeEmprunt(typeEmprunt);
        empruntDetailInsert = empruntDetailRepository.save(empruntDetailInsert);

        // Mettre à jour l'historique du livre
        StatutLivre statutEmprunte = statutLivreRepository.findById(2).orElse(null); // ID 2 = Emprunté
        HistoriqueLivre historique = new HistoriqueLivre();
        historique.setLivre(livre);
        historique.setStatut(statutEmprunte);
        historique.setDateDebut(dateDebutProlongement);
        historiqueLivreRepository.save(historique);

        return empruntDetailInsert;

    }

    public String nomLivreProlonger(Integer id){
        return empruntDetailRepository.nomLivreProlonger(id);
    }

    public void retournerEmprunt(Integer idEmpruntDetail, LocalDate dateRetour) {
        EmpruntDetail empruntDetail = empruntDetailRepository.findById(idEmpruntDetail).orElse(null);
        if (empruntDetail != null) {


            if (dateRetour.isBefore(empruntDetail.getDateDebut())){
                throw new RuntimeException("La date de retour doit etre plus grand que la date debut d'emprunt");
            }

            if (dateRetour.isAfter(empruntDetail.getDateFin())){
                if (penaliteRepository.estPenaliser(idEmpruntDetail) == null){
                    empruntDetail.setDateRetour(dateRetour);
                    empruntDetail = empruntDetailRepository.save(empruntDetail);
                    // Mettre à jour l'historique du livre
                    StatutLivre statutDisponible = statutLivreRepository.findById(1).orElse(null); // ID 1 = Disponible
                    HistoriqueLivre historique = new HistoriqueLivre();
                    historique.setLivre(empruntDetail.getLivre());
                    historique.setStatut(statutDisponible);
                    historique.setDateDebut(dateRetour);
                    historiqueLivreRepository.save(historique);
                    throw new RuntimeException("penaliser");
                }
            }

            empruntDetail.setDateRetour(dateRetour);
            empruntDetail = empruntDetailRepository.save(empruntDetail);
            // Mettre à jour l'historique du livre
            StatutLivre statutDisponible = statutLivreRepository.findById(1).orElse(null); // ID 1 = Disponible
            HistoriqueLivre historique = new HistoriqueLivre();
            historique.setLivre(empruntDetail.getLivre());
            historique.setStatut(statutDisponible);
            historique.setDateDebut(dateRetour);
            historiqueLivreRepository.save(historique);
        }
    }

    public List<EmpruntDetail> listeEmpruntUser(Integer idUser) {
        return empruntDetailRepository.getListeEmpruntUser(idUser);
    }
}
