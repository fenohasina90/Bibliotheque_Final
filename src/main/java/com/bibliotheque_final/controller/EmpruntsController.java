package com.bibliotheque_final.controller;

import ch.qos.logback.core.model.Model;
import com.bibliotheque_final.entities.*;
import com.bibliotheque_final.projection.LivreProjection;
import com.bibliotheque_final.repositories.EmpruntDetailRepository;
import com.bibliotheque_final.repositories.HistoriqueLivreRepository;
import com.bibliotheque_final.repositories.StatutLivreRepository;
import com.bibliotheque_final.service.EmpruntService;
import com.bibliotheque_final.service.LivreService;
import com.bibliotheque_final.service.UtilisateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/emprunts")
public class EmpruntsController {
    private final EmpruntService empruntService;
    private final LivreService livreService;
    private final UtilisateurService utilisateurService;
    private final EmpruntDetailRepository empruntDetailRepository;
    private final StatutLivreRepository statutLivreRepository;
    private final HistoriqueLivreRepository historiqueLivreRepository;

    @Autowired
    public EmpruntsController(EmpruntService empruntService, LivreService livreService, UtilisateurService utilisateurService, EmpruntDetailRepository empruntDetailRepository, StatutLivreRepository statutLivreRepository, HistoriqueLivreRepository historiqueLivreRepository) {
        this.empruntService = empruntService;
        this.livreService = livreService;
        this.utilisateurService = utilisateurService;
        this.empruntDetailRepository = empruntDetailRepository;
        this.statutLivreRepository = statutLivreRepository;
        this.historiqueLivreRepository = historiqueLivreRepository;
    }

    @PostMapping("/retourner/{id}")
    public ModelAndView retournerEmprunt(@PathVariable Integer id) {
        empruntService.retournerEmprunt(id, LocalDate.now());
        return new ModelAndView("redirect:/emprunts/mes-emprunts?success=Retour+réussi");
    }


    @GetMapping("/creer")
    public ModelAndView showCreateEmpruntForm(Model model) {
        List<Utilisateur> utilisateurs = utilisateurService.getAllUser();
        List<TypeEmprunt> typesEmprunt = empruntService.getAllType();

        ModelAndView mv = new ModelAndView("emprunt/creer-emprunt");
        mv.addObject("utilisateurs", utilisateurs);
        mv.addObject("typesEmprunt", typesEmprunt);
        mv.addObject("empruntForm", new EmpruntForm());

        return mv;
    }

    @GetMapping("/livres-disponibles")
    @ResponseBody
    public List<LivreProjection> getLivresDisponibles(
            @RequestParam Integer idUtilisateur,
            @RequestParam String dateDebut,
            @RequestParam String dateFin) {

        Integer idAdherant = livreService.getIdAdherant(idUtilisateur);
        return livreService.getLivresDisponibles(
                idAdherant,
                LocalDate.parse(dateDebut)
        );
    }

    @PostMapping("/creer")
    public ModelAndView creerEmprunt(@ModelAttribute EmpruntForm empruntForm) {
        try {
            empruntService.creerEmprunt(
                    empruntForm.getUtilisateurId(),
                    empruntForm.getLivreId(),
                    empruntForm.getDateDebut(),
                    empruntForm.getDateFin(),
                    empruntForm.getTypeEmpruntId()
            );
            return new ModelAndView("redirect:/admin");
        } catch (Exception e) {
            return new ModelAndView("redirect:/emprunts/creer?error=" + e.getMessage());
        }
    }


//    retourr  --------------------------------------------------------------


    @GetMapping("/liste")
    public ModelAndView listePrets() {
        ModelAndView mv = new ModelAndView("emprunt/liste");
        List<EmpruntDetail> emprunts = empruntDetailRepository.findAllByDateRetourIsNull();

        // Vérification des dates null
        emprunts.forEach(emprunt -> {
            if (emprunt.getDateDebut() == null || emprunt.getDateFin() == null) {
                throw new IllegalStateException("Emprunt " + emprunt.getId() + " a des dates invalides");
            }
        });

        mv.addObject("emprunts", emprunts);
        mv.addObject("today", LocalDate.now());
        return mv;
    }

    @GetMapping("/retour/{id}")
    public ModelAndView formulaireRetour(@PathVariable Integer id) {
        ModelAndView mv = new ModelAndView("emprunt/formulaire-retour");
        EmpruntDetail emprunt = empruntDetailRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Emprunt non trouvé"));

        String datedebut =  emprunt.getDateDebut().toString();
        String datefin = emprunt.getDateFin().toString();
        mv.addObject("emprunt", emprunt);
        mv.addObject("dateRetour", LocalDate.now());
        mv.addObject("datedebut", datedebut);
        mv.addObject("datefin", datefin);

        return mv;
    }

    @PostMapping("/retour/{id}")
    public String enregistrerRetour(
            @PathVariable Integer id,
            @RequestParam LocalDate dateRetour,
            RedirectAttributes redirectAttributes) {

        EmpruntDetail emprunt = empruntDetailRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Emprunt non trouvé"));

        emprunt.setDateRetour(dateRetour);
        empruntDetailRepository.save(emprunt);

        // Mettre à jour l'historique du livre
        StatutLivre statutDisponible = statutLivreRepository.findById(1) // 1 = Disponible
                .orElseThrow(() -> new RuntimeException("Statut non trouvé"));

        HistoriqueLivre historique = new HistoriqueLivre();
        historique.setLivre(emprunt.getLivre());
        historique.setStatut(statutDisponible);
        historique.setDateDebut(dateRetour);
        historiqueLivreRepository.save(historique);

        redirectAttributes.addFlashAttribute("success", "Retour enregistré avec succès");
        return "redirect:/emprunts/liste";
    }
}
