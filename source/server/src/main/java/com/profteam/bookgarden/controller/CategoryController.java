package com.profteam.bookgarden.controller;

import com.profteam.bookgarden.constants.AppConstants;
import com.profteam.bookgarden.dto.CategoryDto;
import com.profteam.bookgarden.service.category.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(AppConstants.API_CATEGORY)
public class CategoryController {
    
    @Autowired
    private ICategoryService categoryService;
    
    @GetMapping("{id}")
    public ResponseEntity<CategoryDto> findById(@PathVariable int id) {
        CategoryDto categoryDto = new CategoryDto(categoryService.findById(id));
        
        return ResponseEntity.ok(categoryDto);
    }
    
}
