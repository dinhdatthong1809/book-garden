package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.validator.notnull.NotNull;
import com.profteam.bookgarden.validator.number.Number;
import com.profteam.bookgarden.validator.number.NumberEnum;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageRequestDto {

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    @Number(type = NumberEnum.UNSIGNED_INTEGER)
    private String page;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    @Number(type = NumberEnum.UNSIGNED_INTEGER)
    private String size = "10";

}
