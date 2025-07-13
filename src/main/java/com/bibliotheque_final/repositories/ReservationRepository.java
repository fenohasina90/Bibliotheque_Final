package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Reservation;
import com.bibliotheque_final.projection.ReservationProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    @Query(value = """
        select r.id as id, u.nom ||' '||u.prenom as nom, l.titre as titre, r.date_debut as dateReservation, st.nom as statut, 
        his.date_debut as majStatut 
        from reservation r
        join utilisateur u on u.id = r.utilisateur_id
        join livre l on l.id = r.livre_id
        join historique_reservation his on his.reservation_id = r.id
        join statut_reservation st on his.statut_id = st.id
        where his.id = (
            select MAX(hr.id) 
            from historique_reservation hr 
            where hr.reservation_id = r.id
        )
        order by r.id asc
    """, nativeQuery = true)
    List<ReservationProjection> getlisteReservationAdmin();
}