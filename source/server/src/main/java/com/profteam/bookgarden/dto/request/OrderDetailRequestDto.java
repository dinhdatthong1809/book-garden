package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.validator.notnull.NotNull;
import com.profteam.bookgarden.validator.number.Number;
import com.profteam.bookgarden.validator.number.NumberEnum;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailRequestDto {

    @NotNull
    private String bookId;

    @NotNull
    @Number(type = NumberEnum.UNSIGNED_INTEGER)
    private int amount;

    @Number(type = NumberEnum.SIGNED_INTEGER)
    private double price;

}
