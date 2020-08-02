package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.validator.notnull.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ListBestSellerRequestDto {

    @NotNull
//    @Number
    private int size;

}
