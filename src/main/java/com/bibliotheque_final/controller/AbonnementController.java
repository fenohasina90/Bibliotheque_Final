package com.bibliotheque_final.controller;

import com.bibliotheque_final.entities.Abonnement;
import com.bibliotheque_final.service.AbonnementService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@RestController
@RequestMapping("/abonnement")
public class AbonnementController {
    private final AbonnementService abonnementService;

    @Autowired
    public AbonnementController(AbonnementService abonnementService) {
        this.abonnementService = abonnementService;
    }
    @GetMapping("")
    public ModelAndView showAbonnement(HttpSession session){
        Integer idUser = (Integer) session.getAttribute("utilisateurConnecte");
        ModelAndView mv = new ModelAndView("abonnement/abonnement");
        mv.addObject("listes", abonnementService.getListeAbonnementUser(idUser));
        return mv;
    }

    @GetMapping("/form")
    public ModelAndView showForm(){
        ModelAndView mv = new ModelAndView("abonnement/abonnementForm");
        return mv;
    }

    @PostMapping("/traitement")
    public ModelAndView traitementForm(@RequestParam("dateDebut")LocalDate dateDebut, @RequestParam("dateFin") LocalDate dateFin, HttpSession session) {
        ModelAndView mv = new ModelAndView("redirect:/abonnement");
        Integer idUser = (Integer) session.getAttribute("utilisateurConnecte");
        abonnementService.save(idUser,dateDebut, dateFin);
        return mv;
    }

}
