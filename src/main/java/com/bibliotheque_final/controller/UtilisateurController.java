package com.bibliotheque_final.controller;

import com.bibliotheque_final.entities.Utilisateur;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bibliotheque_final.service.UtilisateurService;

@Controller
@RequestMapping("/")
public class UtilisateurController {
    private final UtilisateurService utilisateurService;

    @Autowired
    public UtilisateurController(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
    }

    @GetMapping("/")
     public ModelAndView loginForm (){
        ModelAndView mv = new ModelAndView("auth/login");
        return mv;
    }

    @GetMapping("/accueil")
    public ModelAndView home (){
        ModelAndView mv = new ModelAndView("livre/listeLivres");
        return mv;
    }

    @GetMapping("/admin")
    public ModelAndView homeAdmin (){
        ModelAndView mv = new ModelAndView("admin/home");
        return mv;
    }

    @PostMapping("/login")
    public ModelAndView validationlogin(@RequestParam("email") String email,
                                        @RequestParam("password") String password,
                                        HttpSession session) {
        Utilisateur utilisateurConnecte = utilisateurService.login(email, password);

        if (utilisateurConnecte != null) {

            if (utilisateurConnecte.getEstAdmin() == true) {
                return new ModelAndView("redirect:/admin");
            } else {
                
                session.setAttribute("utilisateurConnecte", utilisateurConnecte);
                return new ModelAndView("redirect:/livre"); // redirige vers page d accueil
            }
        } else {
            // Authentification echouee : on retourne au formulaire avec message d'erreur
            ModelAndView mav = new ModelAndView("auth/login"); // le nom de votre JSP login.jsp
            mav.addObject("erreur", "Email ou mot de passe incorrect.");
            return mav;
        }
    }

}
