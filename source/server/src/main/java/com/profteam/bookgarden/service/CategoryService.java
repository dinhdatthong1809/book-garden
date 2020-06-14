package com.profteam.bookgarden.service;

import com.profteam.bookgarden.dom.Category;
import com.profteam.bookgarden.exception.EntityCustomNotFoundException;
import com.profteam.bookgarden.repository.ICategoryRepository;
import com.profteam.bookgarden.service.interfaces.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Throwable.class)
public class CategoryService implements ICategoryService {
    
    @Autowired
    private ICategoryRepository categoryRepository;
    
    @Override
    public Category findById(int id) {
        Category category = categoryRepository
                            .findById(id)
                            .orElseThrow(() -> new EntityCustomNotFoundException(id, Category.class));
        
        return category;
    }
    
}
