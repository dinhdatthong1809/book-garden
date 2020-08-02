package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.validator.notnull.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRequestDto {

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String username;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String password;

}
