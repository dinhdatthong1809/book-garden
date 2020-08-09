package com.profteam.bookgarden.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailDto {

    private int amount;

    private double price;

    @JsonIgnoreProperties(value = {"publisher", "author", "category", "image", "price", "description"})
    private BookDto book;

}
