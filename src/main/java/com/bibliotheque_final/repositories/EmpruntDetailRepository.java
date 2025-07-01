package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.EmpruntDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmpruntDetailRepository extends JpaRepository<EmpruntDetail, Integer> {
}