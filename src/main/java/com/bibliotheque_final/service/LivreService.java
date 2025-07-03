package com.bibliotheque_final.service;

import com.bibliotheque_final.projection.LivreProjection;
import com.bibliotheque_final.repositories.LivreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class LivreService {
    private final LivreRepository livreRepository;
    @Autowired
    public LivreService(LivreRepository livreRepository) {
        this.livreRepository = livreRepository;
    }

//    public List<LivreProjection> getLivresDisponibles(Integer idAdherant) {
//        LocalDate aujourdhui = LocalDate.now();
//        return livreRepository.getLivreHome(aujourdhui, idAdherant);
//    }

    // Si vous voulez aussi permettre de spécifier une date
    public List<LivreProjection> getLivresDisponibles(Integer idAdherant, LocalDate date) {
        if (date == null) {
            date = LocalDate.now();
        }
        return livreRepository.getLivreHome(date, idAdherant);
    }
}
