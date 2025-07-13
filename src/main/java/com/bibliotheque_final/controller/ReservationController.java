package com.bibliotheque_final.controller;

import com.bibliotheque_final.entities.Utilisateur;
import com.bibliotheque_final.service.ReservationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@RestController
@RequestMapping("/reservation")
public class ReservationController {
    private final ReservationService reservationService;
    @Autowired
    public ReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }


    @PostMapping("")
    public ModelAndView getInfoReservation(@RequestParam("livreId") Integer livreId){
        ModelAndView mv = new ModelAndView("livre/reservationForm");
        mv.addObject("livreId", livreId);
        return mv;
    }

    @PostMapping("/create")
    public ModelAndView saveReservation(
            @RequestParam("livreId") Integer IdLivre,
            @RequestParam("dateDebut") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateLivraison,
            HttpSession session) {

        ModelAndView mv = new ModelAndView("livre/reservationForm");
        mv.addObject("livreId", IdLivre);

        Integer id_utilisateur = (Integer) session.getAttribute("utilisateurConnecte");

        if (!reservationService.estAbonne(id_utilisateur, dateLivraison)){
            mv.addObject("erreur", "Vous n etes pas abonnee");
            return mv;
        } else if (!reservationService.estDisponible(IdLivre, dateLivraison)) {
            mv.addObject("erreur", "Ce livre n est plus disponible");
            return mv;
        } else if (!reservationService.valideAgeLivre(id_utilisateur, IdLivre)) {
            mv.addObject("erreur", "Ce livre n est pas pour votre age");
            return mv;
        }

        mv.addObject("success", "Reservation en attente");
        reservationService.save(id_utilisateur, IdLivre, dateLivraison);
        return mv;
    }

        // Cote ADMIN
    @PostMapping("/annulerstatut")
    public ModelAndView annulerReservation(
            @RequestParam("idReservation") Integer idReservation
    ){
        reservationService.changerStatutReservation(idReservation, 4);
        return new ModelAndView("redirect:/user/reservation");
    }
}
