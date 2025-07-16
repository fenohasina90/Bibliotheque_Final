package com.bibliotheque_final.service;


import java.util.List;
import java.util.Optional;

import com.bibliotheque_final.projection.InfoUserProjection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bibliotheque_final.entities.Utilisateur;
import com.bibliotheque_final.repositories.UtilisateurRepository;

@Service
public class UtilisateurService {
    private final UtilisateurRepository utilisateurRepository;
    @Autowired
    public UtilisateurService(UtilisateurRepository utilisateurRepository) {
        this.utilisateurRepository = utilisateurRepository;
    }

    public Utilisateur login (String email, String mdp) {
        Optional<Utilisateur> utilisateur = utilisateurRepository.findByEmail(email);
        if (utilisateur.isPresent() && utilisateur.get().getMdp().equals(mdp)) {
            return utilisateur.get();
        }
        return null;    
    }

    public List<Utilisateur> getAllUser(){
        return utilisateurRepository.findAll();
    }

    public List<InfoUserProjection> getInfoUser(Integer id){
        return utilisateurRepository.getInfoUserDetails(id);
    }


}
