package com.profteam.bookgarden.dto.request;

import java.util.Date;

import com.profteam.bookgarden.constants.MessageConstants;
import com.profteam.bookgarden.validator.notnull.NotNull;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateUserInfoRequestDto {

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private Long id;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String username;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String password;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String fullname;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private Date dateOfBirth;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String email;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String phoneNumber;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private boolean sex;

    @NotNull(message = "{" + MessageConstants.CONST_MESSAGE_NOT_NULL + "}")
    private String address;

}
