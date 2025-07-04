package com.bibliotheque_final.service;

import com.bibliotheque_final.entities.Abonnement;
import com.bibliotheque_final.entities.Utilisateur;
import com.bibliotheque_final.repositories.AbonnementRepository;
import com.bibliotheque_final.repositories.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

@Service
public class AbonnementService {
    private final AbonnementRepository abonnementRepository;
    private final UtilisateurRepository utilisateurRepository;
    @Autowired
    public AbonnementService(AbonnementRepository abonnementRepository, UtilisateurRepository utilisateurRepository) {
        this.abonnementRepository = abonnementRepository;
        this.utilisateurRepository = utilisateurRepository;
    }

    public void save(Integer idUser, LocalDate dateDebut, LocalDate dateFin){
        Utilisateur user = utilisateurRepository.findById(idUser).orElse(null);
        Abonnement abonnement = new Abonnement();
        abonnement.setUtilisateur(user);
        abonnement.setDateDebut(dateDebut);
        abonnement.setDateFin(dateFin);
        abonnementRepository.save(abonnement);
    }

    public List<Abonnement> getListeAbonnementUser(Integer idUser){
        return abonnementRepository.findAllByIdUser(idUser);
    }
}
