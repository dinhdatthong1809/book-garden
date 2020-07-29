package com.profteam.bookgarden.repository;

import com.profteam.bookgarden.dom.Bookshelf;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IBookShelfRepository extends JpaRepository<Bookshelf, Integer> {

}
