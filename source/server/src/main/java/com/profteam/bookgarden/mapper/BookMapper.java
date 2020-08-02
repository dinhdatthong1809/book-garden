package com.profteam.bookgarden.mapper;

import java.util.List;
import java.util.Set;

import org.mapstruct.Mapper;

import com.profteam.bookgarden.dom.Book;
import com.profteam.bookgarden.dto.BookDto;

@Mapper
public interface BookMapper {

    BookDto toBookDto(Book book);

    List<BookDto> toListBookDto(List<Book> books);

    Set<BookDto> toListBookDto(Set<Book> books);

}
