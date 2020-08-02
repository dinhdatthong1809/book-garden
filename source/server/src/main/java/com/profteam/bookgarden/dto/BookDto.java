package com.profteam.bookgarden.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookDto {

    private String id;

    private String title;

    private String description;

    private Double price;

    private String image;

    private List<CategoryDto> categories;

    private List<AuthorDto> authors;

    private PublisherDto publisher;

}
