package com.bibliotheque_final.controller;

import com.bibliotheque_final.entities.Emprunt;
import com.bibliotheque_final.entities.Utilisateur;
import com.bibliotheque_final.repositories.EmpruntRepository;
import com.bibliotheque_final.service.PenaliteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/penalite")
public class PenaliteController {
    private final PenaliteService penaliteService;
    private final EmpruntRepository empruntRepository;
    @Autowired
    public PenaliteController(PenaliteService penaliteService,
                              EmpruntRepository empruntRepository) {
        this.penaliteService = penaliteService;
        this.empruntRepository = empruntRepository;
    }

    @GetMapping("/creer/{id}")
    public ModelAndView penaliteForm(@PathVariable Integer id){
        ModelAndView mv = new ModelAndView("penalite/penaliteForm");
        mv.addObject("idEmprunt", id);
        return mv;
    }

    @PostMapping("/creer/{id}")
    public ModelAndView enregistrerPenalite(
            @PathVariable Integer id,
            @RequestParam Integer sanction) {

        Emprunt emprunt = empruntRepository.findById(id).orElse(null);
        Utilisateur user = emprunt.getUtilisateur();
        Integer idUser = user.getId();
        ModelAndView mv = new ModelAndView("redirect:/emprunts");

        if (penaliteService.estDejaPenaliser(id)){
            ModelAndView mav = new ModelAndView("penalite/penaliteForm");
            mav.addObject("idEmprunt", id);
            mav.addObject("erreur", "C'est deja penalisee");
            return mav;
        }
        penaliteService.creerPenalite(idUser, id, sanction);

        return mv;
    }
}
