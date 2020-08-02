package com.profteam.bookgarden.mapper;

import java.util.List;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.Category;
import com.profteam.bookgarden.dto.CategoryDto;

@Mapper
public interface CategoryMapper {

    CategoryDto toCategoryDto(Category category);

    List<CategoryDto> toListCategoryDto(List<Category> categories);

}
