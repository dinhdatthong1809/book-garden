package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.validator.notnull.NotNull;

import lombok.Setter;
import lombok.Getter;

@Getter
@Setter
public class RegisterRequestDto {

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String username;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String password;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String confirmPassword;
    
}
