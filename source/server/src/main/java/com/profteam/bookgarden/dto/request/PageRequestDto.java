package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.validator.notnull.NotNull;
import com.profteam.bookgarden.validator.number.Number;
import com.profteam.bookgarden.validator.number.NumberEnum;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageRequestDto {

    @NotNull
    @Number(type = NumberEnum.UNSIGNED_INTEGER)
    private String page;

    @NotNull
    @Number(type = NumberEnum.UNSIGNED_INTEGER)
    private String size = "1";

}
