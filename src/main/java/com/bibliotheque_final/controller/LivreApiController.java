package com.bibliotheque_final.controller;

import com.bibliotheque_final.projection.InfoUserProjection;
import com.bibliotheque_final.projection.LivreProjection;
import com.bibliotheque_final.service.LivreService;
import com.bibliotheque_final.service.UtilisateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class LivreApiController {
    private final LivreService livreService;
    private final UtilisateurService utilisateurService;
    @Autowired
    public LivreApiController(LivreService livreService,
                              UtilisateurService utilisateurService) {
        this.livreService = livreService;
        this.utilisateurService = utilisateurService;
    }

    @GetMapping("/livre/{id}")
    @ResponseBody
    public Map<String, Object> getLivreDetail(@PathVariable Integer id){
        Map<String, Object> res = new HashMap<>();
        try{
            LivreProjection livreProjection = livreService.getLivreJson(id);
            if (livreProjection != null){
                res.put("id", livreProjection.getLivreId().toString());
                res.put("titre", livreProjection.getTitre().toString());
                res.put("Auteur", livreProjection.getAuteur().toString());
                res.put("Exemplaire", livreProjection.getExemplaire().toString());
                res.put("Disponible", livreProjection.getDisponible().toString());
            }else{
                res.put("error", "livre non trouve");
            }

        }catch (Exception e) {
            res.put("error", "erreur lors de la recuperation de cette livre : "+e.getMessage());
        }
        return res;
    }

    @GetMapping("/user/{id}")
    @ResponseBody
    public Map<String, Object> getInfoUser(@PathVariable Integer id){
        Map<String, Object> res = new HashMap<>();
        try{
            List<InfoUserProjection> infoUserProjections = utilisateurService.getInfoUser(id);
            if (!infoUserProjections.isEmpty()){
                res.put("Info", infoUserProjections);
//                for (InfoUserProjection user: infoUserProjections) {
//                    res.put("ID", user.getId());
//                    res.put("Nom", user.getNom());
//                    res.put("Type Adherant", user.getTypeAdherant());
//                    res.put("Quota Pret", user.getQuotaPret());
//                    res.put("Pret en Cours", user.getPretCours());
//                    res.put("Reste Pret", user.getRestePret());
//                    res.put("Debut Abonnement", user.getDebutAbonnement());
//                    res.put("Fin Abonnement", user.getFinAbonnement());
//                    res.put("Debut Penalite", user.getPenaliteDebut());
//                    res.put("Fin Penalite", user.getPenaliteFin());
//                }

            }else{
                res.put("error", "Utilisateur non trouve");
            }

        }catch (Exception e) {
            res.put("error", "erreur lors de la recuperation de cette utilisateur : "+e.getMessage());
        }
        return res;
    }


}
