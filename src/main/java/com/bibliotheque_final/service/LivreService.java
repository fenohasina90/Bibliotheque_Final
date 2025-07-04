package com.bibliotheque_final.service;

import com.bibliotheque_final.projection.LivreProjection;
import com.bibliotheque_final.repositories.AdherantRepository;
import com.bibliotheque_final.repositories.LivreRepository;
import com.bibliotheque_final.repositories.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class LivreService {
    private final LivreRepository livreRepository;
    private final UtilisateurRepository utilisateurRepository;
    private final AdherantRepository adherantRepository;
    @Autowired
    public LivreService(LivreRepository livreRepository, UtilisateurRepository utilisateurRepository, AdherantRepository adherantRepository) {
        this.livreRepository = livreRepository;
        this.utilisateurRepository = utilisateurRepository;
        this.adherantRepository = adherantRepository;
    }

    public List<LivreProjection> getLivresDisponibles(Integer idAdherant, LocalDate date) {
        if (date == null) {
            date = LocalDate.now();
        }
        return livreRepository.getLivreHome(date, idAdherant);
    }

    public Integer getIdAdherant(Integer id){
        return utilisateurRepository.getIdAdherant(id);
    }

}
