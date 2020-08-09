package com.profteam.bookgarden.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailRequestDto {

    private String bookId;

    private int amount;

    private double price;

}
