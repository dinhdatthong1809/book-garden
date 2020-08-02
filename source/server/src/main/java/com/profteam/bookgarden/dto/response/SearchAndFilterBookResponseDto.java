package com.profteam.bookgarden.dto.response;

import java.util.List;

import com.profteam.bookgarden.dto.BookDto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchAndFilterBookResponseDto {

    List<BookDto> list;

    long totalElements;

}
