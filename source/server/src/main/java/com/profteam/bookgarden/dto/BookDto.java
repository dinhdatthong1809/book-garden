package com.profteam.bookgarden.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookDto {

    private String id;

    private String title;

    private String description;
    
    private String introduce;

    private int pageNum;

    private int amount;

    private Double price;
    
    private String image;

    private CategoryDto category;

    private AuthorDto author;

    private PublisherDto publisher;

}
