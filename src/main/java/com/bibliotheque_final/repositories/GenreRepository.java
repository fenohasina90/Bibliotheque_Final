package com.bibliotheque_final.repositories;

import com.bibliotheque_final.entities.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreRepository extends JpaRepository<Genre, Integer> {
}