package com.profteam.bookgarden.dto.response;

import com.profteam.bookgarden.dto.BookDto;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ListBookResponseDto {

     private List<BookDto> listBook;

}
