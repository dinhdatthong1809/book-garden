package com.profteam.bookgarden.mapper;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.Author;
import com.profteam.bookgarden.dto.AuthorDto;

@Mapper
public interface AuthorMapper {

    AuthorDto toAuthorDto(Author author);

}
