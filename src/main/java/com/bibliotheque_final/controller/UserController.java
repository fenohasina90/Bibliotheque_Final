package com.bibliotheque_final.controller;

import com.bibliotheque_final.service.AbonnementService;
import com.bibliotheque_final.service.EmpruntService;
import com.bibliotheque_final.service.ReservationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/user")
public class UserController {
    private final EmpruntService empruntService;
    private final ReservationService reservationService;
    private final AbonnementService abonnementService;
    @Autowired
    public UserController(EmpruntService empruntService, ReservationService reservationService, AbonnementService abonnementService) {
        this.empruntService = empruntService;
        this.reservationService = reservationService;
        this.abonnementService = abonnementService;
    }

    @GetMapping("/abonnement")
    public ModelAndView showAbonnement(HttpSession session){
        Integer idUser = (Integer) session.getAttribute("utilisateurConnecte");
        ModelAndView mv = new ModelAndView("abonnement/abonnement");
        mv.addObject("listes", abonnementService.getListeAbonnementUser(idUser));
        return mv;
    }

    @GetMapping("/emprunt")
    public ModelAndView getListeEmprunt(HttpSession session){
        ModelAndView mv = new ModelAndView("/livre/empruntuser");
        Integer idUser = (Integer) session.getAttribute("utilisateurConnecte");
        mv.addObject("listes", empruntService.listeEmpruntUser(idUser));
        return mv;
    }
}
