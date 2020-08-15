package com.profteam.bookgarden.dto.request;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.validator.notnull.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterRequestDto {

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String username;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String password;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String confirmPassword;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String fullname;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String phoneNumber;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String address;

}
