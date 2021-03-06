package com.profteam.bookgarden.service;

import java.util.List;

import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.profteam.bookgarden.dto.CategoryDto;
import com.profteam.bookgarden.mapper.CategoryMapper;
import com.profteam.bookgarden.repository.CategoryRepository;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Throwable.class)
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    private final CategoryMapper categoryMapper = Mappers.getMapper(CategoryMapper.class);

    public List<CategoryDto> findAll() {
        return categoryMapper.toListCategoryDto(categoryRepository.findAll());
    }

}
