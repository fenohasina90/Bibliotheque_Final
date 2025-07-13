package com.bibliotheque_final.service;

import com.bibliotheque_final.entities.Emprunt;
import com.bibliotheque_final.entities.Penalite;
import com.bibliotheque_final.repositories.EmpruntDetailRepository;
import com.bibliotheque_final.repositories.EmpruntRepository;
import com.bibliotheque_final.repositories.PenaliteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class PenaliteService {
    private final EmpruntDetailRepository empruntDetailRepository;
    private final EmpruntRepository empruntRepository;
    private final PenaliteRepository penaliteRepository;
    @Autowired
    public PenaliteService(EmpruntDetailRepository empruntDetailRepository,
                           EmpruntRepository empruntRepository,
                           PenaliteRepository penaliteRepository) {
        this.empruntDetailRepository = empruntDetailRepository;
        this.empruntRepository = empruntRepository;
        this.penaliteRepository = penaliteRepository;
    }

    public boolean estDejaPenaliser(Integer idEmprunt){
        return penaliteRepository.estPenaliser(idEmprunt) != null;
    }

    public void creerPenalite (Integer idUser, Integer idEmprunt ,Integer caution) {
        List<Penalite> listePenaliteUser = penaliteRepository.getListPenliteUser(idUser);
        Emprunt emprunt = empruntRepository.findById(idEmprunt).orElse(null);

        if (listePenaliteUser.isEmpty()) {

            Penalite penalite = new Penalite();
            penalite.setDateDebut(LocalDate.now());
            penalite.setEmprunt(emprunt);
            penalite.setDateFin(LocalDate.now().plusDays(caution));
            penalite.setSanction(caution);

            penaliteRepository.save(penalite);

        } else {

            LocalDate dateFinMaxPenalite = penaliteRepository.getDateMaxPenalite(idUser);
            if (dateFinMaxPenalite.isAfter(LocalDate.now())) {

                Penalite penalite = new Penalite();
                penalite.setSanction(caution);
                penalite.setEmprunt(emprunt);
                penalite.setDateDebut(dateFinMaxPenalite.plusDays(1));
                penalite.setDateFin(dateFinMaxPenalite.plusDays(caution+1));

                penaliteRepository.save(penalite);
            } else {
                Penalite penalite = new Penalite();
                penalite.setDateDebut(LocalDate.now());
                penalite.setEmprunt(emprunt);
                penalite.setDateFin(LocalDate.now().plusDays(caution));
                penalite.setSanction(caution);

                penaliteRepository.save(penalite);
            }

        }
    }
}
