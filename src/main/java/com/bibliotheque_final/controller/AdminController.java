package com.bibliotheque_final.controller;

import com.bibliotheque_final.service.AbonnementService;
import com.bibliotheque_final.service.LivreService;
import com.bibliotheque_final.service.ReservationService;
import com.bibliotheque_final.service.UtilisateurService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@RestController
@RequestMapping("/admin")
public class AdminController {
    private final ReservationService reservationService;
    private final LivreService livreService;
    private final AbonnementService abonnementService;
    private final UtilisateurService utilisateurService;

    public AdminController(ReservationService reservationService,
                           LivreService livreService,
                           AbonnementService abonnementService,
                           UtilisateurService utilisateurService) {
        this.reservationService = reservationService;
        this.livreService = livreService;
        this.abonnementService = abonnementService;
        this.utilisateurService = utilisateurService;
    }
    @GetMapping("")
    public ModelAndView homeAdmin (){
        ModelAndView mv = new ModelAndView("admin/home");
        mv.addObject("listes", abonnementService.getlisteAbonnement());
        return mv;
    }

    /*
     * Valider reservation id statut = 3
     * Refuser reservation id statut = 2
     * Annuler reservation id statut = 4
     * Terminer reservation id statut = 5
     * */

    @GetMapping("/reservation")
    public ModelAndView listeReservation(){
        ModelAndView mv = new ModelAndView("admin/reservation");
        mv.addObject("listes", reservationService.getListeReservationAdmin());
        mv.addObject("today", LocalDate.now());
        return mv;
    }

    @PostMapping("/reservation/validestatut")
    public ModelAndView valideReservation(
            @RequestParam("idReservation") Integer idReservation
    ){
        reservationService.changerStatutReservation(idReservation, 3);
        return new ModelAndView("redirect:/admin/reservation");
    }

    @PostMapping("/reservation/refuserstatut")
    public ModelAndView refuserReservation(
            @RequestParam("idReservation") Integer idReservation
    ){
        reservationService.changerStatutReservation(idReservation, 2);
        return new ModelAndView("redirect:/admin/reservation");
    }
    @PostMapping("/reservation/terminerstatut")
    public ModelAndView terminerReservation(
            @RequestParam("idReservation") Integer idReservation
    ){
        reservationService.changerStatutReservation(idReservation, 5);
        return new ModelAndView("redirect:/admin/reservation");
    }



}
