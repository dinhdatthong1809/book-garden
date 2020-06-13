package com.profteam.bookgarden.dto;

import com.profteam.bookgarden.dom.Category;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class CategoryDto {
    
    private int id;
    
    private String name;
    
    private String description;
    
    public CategoryDto(Category category) {
        id = category.getId();
        name = category.getName();
        description = category.getDescription();
    }
    
}
