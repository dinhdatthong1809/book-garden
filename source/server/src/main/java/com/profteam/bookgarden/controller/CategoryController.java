package com.profteam.bookgarden.controller;

import com.profteam.bookgarden.constants.AppConstants;
import com.profteam.bookgarden.dom.Book;
import com.profteam.bookgarden.dom.Bookshelf;
import com.profteam.bookgarden.repository.IBookRepository;
import com.profteam.bookgarden.repository.IBookShelfRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.persistence.EntityManager;

@RestController
@RequestMapping(AppConstants.API_CATEGORY)
public class CategoryController {
    
    @Autowired
    private IBookShelfRepository bookShelfRepository;
    
    @Autowired
    private IBookRepository bookRepository;
    
    @Autowired
    private EntityManager entityManager;
    
    @GetMapping("demo")
    @Transactional
    public String test() {
        Book book1 = bookRepository.getByIdAndBookshelfId(1, 1);
        Bookshelf bookshelf1 = book1.getBookshelf();
        
        Book book2 = bookRepository.getByIdAndBookshelfId(3, 1);
        Bookshelf bookshelf2 = book2.getBookshelf();
    
        entityManager.detach(bookshelf2);
        
        Bookshelf bookshelf3 = new Bookshelf();
        bookshelf3.setId(1);
        bookshelf3.setLocationName("test");
        bookshelf3.setMaxStorage(7);
        
        bookShelfRepository.save(bookshelf3);
        
        return "test xong";
    }
    
    @Transactional
    public void nested() {
    
    }
    
}
