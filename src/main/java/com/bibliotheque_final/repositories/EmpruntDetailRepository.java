package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.EmpruntDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface EmpruntDetailRepository extends JpaRepository<EmpruntDetail, Integer> {
    @Query("SELECT ed FROM EmpruntDetail ed WHERE ed.livre.id = :livreId AND " +
            "((ed.dateDebut BETWEEN :dateDebut AND :dateFin) OR " +
            "(ed.dateFin BETWEEN :dateDebut AND :dateFin) OR " +
            "(ed.dateDebut <= :dateDebut AND ed.dateFin >= :dateFin))")
    List<EmpruntDetail> findByLivreIdAndDateRange(@Param("livreId") Integer livreId,
                                                  @Param("dateDebut") LocalDate dateDebut,
                                                  @Param("dateFin") LocalDate dateFin);



    @Query("SELECT COUNT(ed) FROM EmpruntDetail ed WHERE ed.emprunt.utilisateur.id = :utilisateurId AND ed.dateFin > :date")
    Integer countByUtilisateurIdAndDateFinAfter(@Param("utilisateurId") Integer utilisateurId,
                                                @Param("date") LocalDate date);

    @Query("SELECT ed FROM EmpruntDetail ed WHERE ed.emprunt.utilisateur.id = :utilisateurId AND ed.dateFin < :date AND ed.dateRetour IS NULL")
    List<EmpruntDetail> findByUtilisateurIdAndDateFinBeforeAndDateRetourIsNull(@Param("utilisateurId") Integer utilisateurId,
                                                                               @Param("date") LocalDate date);


    List<EmpruntDetail> findAllByDateRetourIsNull();

    @Query("SELECT ed FROM EmpruntDetail ed WHERE ed.emprunt.utilisateur.id = :userId AND ed.dateRetour IS NULL")
    List<EmpruntDetail> findEnCoursByUtilisateur(@Param("userId") Integer userId);

    @Query(value = """
        select e.id emprunt_nahazona_penalite from emprunt_detail ed
        join emprunt e on e.id = ed.emprunt_id
        join utilisateur u on u.id = e.utilisateur_id
        where ((ed.date_fin < CURRENT_DATE and ed.date_retour is null) or ed.date_retour > ed.date_fin) and u.id = :idUser
        group by e.id
    """, nativeQuery = true)
    List<Integer> getListeEmpruntPenaliser(@Param("idUser") Integer idUser);

    @Query(value = """
        select e.id emprunt_nahazona_penalite from emprunt_detail ed
        join emprunt e on e.id = ed.emprunt_id
        join utilisateur u on u.id = e.utilisateur_id
        where ((ed.date_fin < CURRENT_DATE and ed.date_retour is null) or ed.date_retour > ed.date_fin) and u.id = :idUser
        group by e.id
    """, nativeQuery = true)
    Integer getPremierEmpruntPenaliser(@Param("idUser") Integer idUser);

    @Query("""
        SELECT ed FROM EmpruntDetail ed WHERE ed.emprunt.utilisateur.id = :idUser
    """)
    List<EmpruntDetail> getListeEmpruntUser(@Param("idUser") Integer idUser);

    @Query("""
        SELECT ed FROM EmpruntDetail ed WHERE ed.emprunt.id = :idEmprunt
    """)
    EmpruntDetail getEmpruntDetail(@Param("idEmprunt") Integer idEmprunt);

    @Query("""
        SELECT ed.livre.titre FROM EmpruntDetail ed WHERE ed.emprunt.id = :idEmprunt
    """)
    String nomLivreProlonger(@Param("idEmprunt") Integer idEmprunt);

}