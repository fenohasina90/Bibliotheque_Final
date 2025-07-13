package com.bibliotheque_final.controller;

import com.bibliotheque_final.entities.Adherant;
import com.bibliotheque_final.entities.Utilisateur;
import com.bibliotheque_final.projection.LivreProjection;
import com.bibliotheque_final.service.LivreService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/user")
public class LivreController {
    private final LivreService livreService;
    @Autowired
    public LivreController(LivreService livreService) {
        this.livreService = livreService;
    }

    @GetMapping("/")
    public ModelAndView afficherLivre(
            HttpSession session,
            @RequestParam(required = false) String dateStr
    ) {

        Integer idUser = (Integer) session.getAttribute("utilisateurConnecte");;
        Integer idAdherant =  livreService.getIdAdherant(idUser);

        // Conversion de la date si fournie, sinon date du jour
        LocalDate localDate = dateStr != null ? LocalDate.parse(dateStr) : LocalDate.now();
        Date dateRecherche = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

        // Appel du service
        List<LivreProjection> livres = livreService.getLivresDisponibles(idAdherant, localDate);

        ModelAndView mv = new ModelAndView("livre/listeLivres");
        mv.addObject("livres", livres);
        mv.addObject("dateRecherche", dateRecherche);
        mv.addObject("idAdherant", idAdherant);

        return mv;
    }
}
