package com.profteam.bookgarden.repository;

import com.profteam.bookgarden.dom.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IBookRepository extends JpaRepository<Book, Integer> {

    Book getByIdAndBookshelfId(Integer id, Integer bookShelfId);
    
}
